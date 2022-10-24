//
//  AppDelegate.swift
//  Chat-View-Example
//
//  Created by Sparkout on 22/10/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UIScrollView.appearance().keyboardDismissMode = .interactive
        return true
    }
}

