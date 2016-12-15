//
//  RSSReaderService.swift
//  RSSReaderApp
//
//  Created by 川崎 隆介 on 2015/12/19.
//  Copyright (c) 2015年 川崎 隆介. All rights reserved.
//

import UIKit

class RSSService: NSObject {
    let site = "https://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://rss.itmedia.co.jp/rss/2.0/news_bursts.xml&num=8"
    var delegate:ParserDelegate?
    
    func requestRSS() {
        if let url = URL(string: site) {
            let req = URLRequest(url: url)
            
            //NSURLConnection.sendAsynchronousRequest(req, queue: OperationQueue.main, completionHandler: self.responseRSS as! (URLResponse?, Data?, Error?) -> Void)
            let session = URLSession.shared
            let task = session.dataTask(with:req, completionHandler:self.responseRSS)
            task.resume()

        }
        
    }
    
    func responseRSS(_ data:Data?,res:URLResponse?,
        error:Error?){
            var entries:Array<[String:AnyObject]> = []
            if let resData = data {
                do {
                    let json = try JSONSerialization.jsonObject(with:resData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                    let responseDataDic = json["responseData"] as! NSDictionary
                    let feed = responseDataDic["feed"] as! NSDictionary
                    entries = feed["entries"] as! Array<[String:AnyObject]>
                } catch  {
                    
                }
            }
            if let d = delegate {
                d.parserDidParse(entries)
            }
    }
}
