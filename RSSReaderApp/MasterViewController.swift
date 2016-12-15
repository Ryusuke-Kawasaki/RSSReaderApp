//
//  MasterViewController.swift
//  RSSReaderApp
//
//  Created by 川崎 隆介 on 2015/12/19.
//  Copyright (c) 2015年 川崎 隆介. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController,ParserDelegate{

    let rssService = RSSService()
    var entries:Array<[String:AnyObject]> = []
    
    func parserDidParse(_ entries: Array<[String:AnyObject]>) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        self.entries = entries
        self.tableView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        rssService.delegate = self
        rssService.requestRSS()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                // ニュース記事のURLを取得
                var newsDic = entries[indexPath.row]
                let newsUrl = newsDic["link"] as? String
                //セグエ用にダウンキャストしたWebViewControllerのインスタンス
                let wvc = segue.destination as! WebViewController
                //変数newsUrlの値をWebViewControllerの変数newsUrlに代入
                wvc.urlString = newsUrl!
            }
            
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 

        var newsDic = entries[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = newsDic["title"] as? String
        cell.detailTextLabel?.text = newsDic["publishedDate"] as? String
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

}

