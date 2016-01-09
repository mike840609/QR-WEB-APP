//
//  ViewController.swift
//  webBrowser
//
//  Created by 蔡鈞 on 2016/1/8.
//  Copyright © 2016年 mike840609. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIWebViewDelegate,UITextFieldDelegate{
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var web1: UIWebView!
    @IBOutlet weak var textField1: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //載入網址
        loadurl(textField.text!, web: web1)
        
        //把第一訪問全讓出
        textField.resignFirstResponder()

        return true
    }
    
    //載入網頁請求
    func loadurl(url:String,web:UIWebView){
        
        //自動加入http:// 使用者不需要輸入 自動帶入
        let aurl = NSURL(string: ("http://" + url))
        
        let urlrq = NSURLRequest(URL:aurl! )
        
        web.loadRequest(urlrq)
    }
    
    //使用代理方法 開始載入 動畫
    func webViewDidStartLoad(webView: UIWebView) {
        //網頁自定義齒輪
        loading.startAnimating()
        
        //navbar齒輪
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    //使用代理方法 載入完成 動畫
    func webViewDidFinishLoad(webView: UIWebView) {
        loading.stopAnimating()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}

