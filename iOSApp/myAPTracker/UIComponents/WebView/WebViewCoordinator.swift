//
//  WebViewCoordinator.swift
//  APTracker
//
//  Created by Matteo Visotto on 09/04/22.
//

import Foundation
import WebKit

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    var parent: WebView
    
    init(_ parent: WebView) {
        self.parent = parent
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let host = navigationAction.request.url?.host, let urlString = navigationAction.request.url?.absoluteString {
            if host.lowercased().contains("amazon") {
                if(urlString.lowercased().contains("https://www.amazon.") || urlString.lowercased().contains("https://amazon.") ){
                    parent.viewModel.isAProduct = false
                    parent.viewModel.isWebViewLoading = true
                }
                decisionHandler(.allow)
                return
            }
        }
        decisionHandler(.cancel)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        parent.viewModel.isWebViewLoading = false
        guard let urlString = webView.url?.absoluteString else {return}
        self.parent.viewModel.currentUrl = urlString
        if urlString.range(of: #"(http(s)?\:\/\/)?(www\.)?amazon(\.([a-z]+))+\/([A-Za-z0-9\-\/\%]*)dp\/([A-Z0-9]+)([\/]?)"#, options: .regularExpression) != nil {
            self.parent.viewModel.isAProduct = true
        }
    }
    
}
