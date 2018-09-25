//
//  WebViewController.swift
//  Unity-iPhone
//
//  Created by vickyliao on 2018/9/24.
//

import UIKit
import WebKit
class WebViewController: UIViewController, WKUIDelegate {
    
    @IBOutlet var btnMenu: UIBarButtonItem!
    var webView: WKWebView!
    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        let fullScreenSize = UIScreen.main.bounds.size
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        self.view.addSubview(webView)
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let fullScreenSize = UIScreen.main.bounds.size
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        let webConfiguration = WKWebViewConfiguration()
        //let fullScreenSize = UIScreen.main.bounds.size
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        self.view.addSubview(webView)
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.frame = CGRect(x: Int((fullScreenSize.width * 0.5)) , y:Int((fullScreenSize.height * 0.07)) , width: Int((fullScreenSize.width * 0.75)) , height: Int((fullScreenSize.height * 0.18)))
        webView.load(myRequest)
    }}
