//
//  AppDelegate.swift
//  SberProject
//
//  Created by Алена on 05.08.2021.
//


import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let rootVC = AuthViewController()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = rootVC
        window.makeKeyAndVisible()
        self.window = window
        return true
    }
}

