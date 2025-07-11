//  ClaraMobileChallenge
//  Created by ETS on 10/07/25.

import SwiftUI
import OAuthSwift

@main
struct ClaraMobileChallengeApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: handleURL)
        }
        
    }
    
    func handleURL(_ url: URL) {
        switch url.host {
        case "oauth-callback":
            OAuthSwift.handle(url: url)
        default:
            assertionFailure("Unsupported host: \(String(describing: url.host))")
        }
    }
}
