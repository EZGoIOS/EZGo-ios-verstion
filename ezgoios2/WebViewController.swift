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
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        btnMenu.target = revealViewController()
        btnMenu.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        let fullScreenSize = UIScreen.main.bounds.size
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
