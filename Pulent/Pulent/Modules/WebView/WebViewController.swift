//
//  WebViewController.swift
//  Pulent
//
//  Created by Matías Contreras Selman on 11/29/18.
//  Copyright © 2018 Matías Contreras. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var url : URL? = nil
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.navigationDelegate = self
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.loadUrl()
    }
    
    func loadUrl(){
        self.webView.showMessage(type: .loading, loopAnimation: true)
        if let url = url {
            self.webView.load(URLRequest(url: url))
        }
    }
}

extension WebViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrint("Error: \(error)")
        self.webView.showMessage(type: .genericError)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webView.removeMessage()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        //if error.code == -1009{ // TIMED OUT:
        self.webView.showMessage(error: error as NSError) {
            //try again...
            self.webView.removeMessage()
            self.loadUrl()
        }
        return
    }
}
