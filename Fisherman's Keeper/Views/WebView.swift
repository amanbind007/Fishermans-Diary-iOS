//
//  WebView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 15/10/23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        print (url.absoluteString)

        webView.load(request)
    }
}
