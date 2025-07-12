//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import SwiftUI
import OAuthSwift

@main
struct ClaraMobileChallengeApp: App {

    @StateObject private var vmAuthentication = AuthenticationViewModel(oauthService: OauthAuthenticator.shared)

    var body: some Scene {
        WindowGroup {
//            ContentView(
//                artistInteractor: ConcreteArtistInteractor(networkInteractor: networkInteractor),
//                releaseInteractor: ConcreteReleasesInteractor(networkInteractor: networkInteractor)
//            )

            AuthenticationView()
                .environmentObject(vmAuthentication)
                .onOpenURL(perform: handleURL)
        }
    }

    private func handleURL(_ url: URL) {
        switch url.host {
        case "oauth-callback":
            OAuthSwift.handle(url: url)
        default:
            assertionFailure("Unsupported host: \(String(describing: url.host))")
        }
    }
}
