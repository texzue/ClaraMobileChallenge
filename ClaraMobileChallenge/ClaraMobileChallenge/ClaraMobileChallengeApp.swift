//
//  ClaraMobileChallengeApp.swift
//  ClaraMobileChallenge
//
//  Created by alice on 10/07/25.
//

import SwiftUI
import SwiftData
import OAuthSwift

@main
struct ClaraMobileChallengeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: handleURL)
        }
        
    }
    
    func handleURL(_ url: URL) {
        if (url.host == "oauth-callback") {
            OAuthSwift.handle(url: url)
        } else {
            // Google provider is the only one with your.bundle.id url schema.
            OAuthSwift.handle(url: url)
        }
    }
}
