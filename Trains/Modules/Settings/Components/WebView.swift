//
//  WebView.swift
//  Trains
//
//  Created by Vsevolod Oplachko on 22.09.2026.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    // MARK: - Properties

    let url: URL

    @Binding var isLoading: Bool
    @Binding var hasFailed: Bool

    // MARK: - UIViewRepresentable

    func makeCoordinator() -> Coordinator {
        Coordinator(isLoading: $isLoading, hasFailed: $hasFailed)
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.scrollView.backgroundColor = .clear
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}

    // MARK: - Coordinator

    @MainActor
    final class Coordinator: NSObject, WKNavigationDelegate {
        @Binding private var isLoading: Bool
        @Binding private var hasFailed: Bool

        init(isLoading: Binding<Bool>, hasFailed: Binding<Bool>) {
            _isLoading = isLoading
            _hasFailed = hasFailed
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            hasFailed = false
            isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            isLoading = false
        }

        func webView(
            _ webView: WKWebView,
            didFail navigation: WKNavigation!,
            withError error: Error
        ) {
            fail()
        }

        func webView(
            _ webView: WKWebView,
            didFailProvisionalNavigation navigation: WKNavigation!,
            withError error: Error
        ) {
            fail()
        }

        private func fail() {
            isLoading = false
            hasFailed = true
        }
    }
}
