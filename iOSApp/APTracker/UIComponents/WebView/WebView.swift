//
//  WebView.swift
//  APTracker
//
//  Created by Matteo Visotto on 09/04/22.
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
    @ObservedObject var viewModel: AddProductViewModel
    
    var webView: WKWebView
    var localUrl: String
    
    init(_ viewModel: AddProductViewModel, stringUrl: String){
        self.localUrl = stringUrl
        self.webView = WKWebView()
        self.viewModel = viewModel
    }
    
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        webView.publisher(for: \.canGoBack)
            .assign(to: &viewModel.$canGoBack)
        webView.publisher(for: \.canGoForward)
            .assign(to: &viewModel.$canGoForward)
        
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: URL(string: self.localUrl)!))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if(viewModel.shouldGoBack){
            uiView.goBack()
            viewModel.shouldGoBack = false
        } else if(viewModel.shouldGoForward){
            uiView.goForward()
            viewModel.shouldGoForward = false
        } else if(viewModel.shouldReloadWithGivenUrl) {
            uiView.load(URLRequest(url: URL(string: viewModel.currentUrl)!))
            viewModel.shouldReloadWithGivenUrl = false
        }
    }
    
    
}
