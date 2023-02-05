//
//  WebViewController.swift
//  NewsApp
//
//  Created by Matvei Bykadorov on 05.02.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var webView: WKWebView!
    var newsUrl: String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let newsUrl = newsUrl else {return}
        guard let url = URL(string: newsUrl) else {return}
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
}
