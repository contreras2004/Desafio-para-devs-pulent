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
        self.webView.showMessage(type: .loading, loopAnimation: true)
        self.webView.navigationDelegate = self
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.loadUrl()
    }
    
    func loadUrl(){
        if let url = url {
            self.webView.load(URLRequest(url: url))
        }
    }
}

extension WebViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrint("Error: \(error)")
        self.view.showMessage(type: .genericError)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webView.removeMessage()
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        debugPrint("Error: \(error)")
        /*if error.code == -1001 { // TIMED OUT:
            
        } else if error.code == -1003 { // SERVER CANNOT BE FOUND
            
        } else if error.code == -1100 { // URL NOT FOUND ON SERVER
            
        }*/
        self.view.showMessage(type: .genericError)
    }
}
