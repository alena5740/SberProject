//
//  AuthViewController.swift
//  SberProject
//
//  Created by Алена on 05.08.2021.
//

import UIKit
import WebKit

// Контроллер для отображения экрана авторизации
final class AuthViewController: UIViewController {
    
    private let webView = WKWebView()
    private let authService = AuthService()
    private let profileAssambly = ProfileAssembly()

    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstaints()
        setupWebView()
    }
    
    private func makeConstaints() {
        view.addSubview(webView)
        webView.frame = view.frame
    }
    
    private func setupWebView() {
        webView.navigationDelegate = self
        let request = URLRequest(url: URL(string: "https://oauth.vk.com/authorize?client_id=7919856&scope=photos,friends&redirect_uri=oauth.vk.com/blank.html&display=mobile&response_type=token")!)
        webView.load(request)
    }
}

extension AuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let urlString = webView.url?.absoluteString ?? ""
        let token = authService.getToken(string: urlString)
        UserDefaultsService.token = token
        authService.authorization(token: token) {
            self.webView.removeFromSuperview()
            let tabBar = profileAssambly.assemblyProfile(userID: "")
            tabBar.modalPresentationStyle = .fullScreen
            self.present(tabBar, animated: true, completion: nil)
        }
    }
}
