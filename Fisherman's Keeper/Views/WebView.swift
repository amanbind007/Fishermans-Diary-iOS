//
//  WebView.swift
//  Fisherman's Keeper
//
//  Created by Aman Bind on 15/10/23.
//

import SwiftUI
import WebKit

// A SwiftUI wrapper for a WebView
struct WebView: UIViewRepresentable {
    // A SwiftUI wrapper for a WebView
    let url: URL

    // Function to create the underlying UIKit WebView
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    // Function to update the WebView with the given URL
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)

        webView.load(request)
    }
}
