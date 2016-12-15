//
//  DetailViewController.swift
//  RSSReaderApp
//
//  Created by 川崎 隆介 on 2015/12/19.
//  Copyright (c) 2015年 川崎 隆介. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    var urlString = ""
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var forwardButton: UIBarButtonItem!
    @IBOutlet weak var reloadButton: UIBarButtonItem!
    var isFinish = false
    
    
    @IBAction func pushForwardButton(_ sender: AnyObject) {
        webView.goForward()
    }
    
    @IBAction func pushBackButton(_ sender: AnyObject) {
        webView.goBack()
    }
    
    @IBAction func pushReloadButton(_ sender: AnyObject) {
        webView.reload()
    }
    
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if (navigationType == UIWebViewNavigationType.linkClicked ) {
            isFinish = false
        }
        return true;
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        if (!isFinish){
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            reloadButton.isEnabled = false
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        backButton.isEnabled = webView.canGoBack
        forwardButton.isEnabled = webView.canGoForward
 
        if !(webView.isLoading) {
            isFinish = true
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            reloadButton.isEnabled = true
        }
        

    }
    
    /*
    override func viewWillDisappear(animated: Bool) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    */
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
        if !(webView.isLoading) {
            isFinish = true
            UIApplication.shared.isNetworkActivityIndicatorVisible = false            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.isEnabled = false
        forwardButton.isEnabled = false
        reloadButton.isEnabled = false
        
        print(urlString)
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

