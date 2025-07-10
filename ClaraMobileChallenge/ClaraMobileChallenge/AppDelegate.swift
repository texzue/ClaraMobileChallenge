//
//  AppDelegate.swift
//  ClaraMobileChallenge
//
//  Created by alice on 10/07/25.
//

import UIKit
import OAuthSwift

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        applicationHandle(url: url)
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        applicationHandle(url: url)
        return true
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        print("message")
    }
    
    func applicationHandle(url: URL) {
        if (url.host == "oauth-callback") {
            OAuthSwift.handle(url: url)
        } else {
            // Google provider is the only one with your.bundle.id url schema.
            OAuthSwift.handle(url: url)
        }
    }
}
