//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import SwiftUI
import OAuthSwift

@main
struct ClaraMobileChallengeApp: App {

    @StateObject private var vmAuthentication = AuthenticationViewModel(oauthService: OauthAuthenticator.shared)
    @StateObject private var vmSearchContent = SearchContentViewModel(artistInteractor: ConcreteArtistInteractor(networkInteractor: ConcreteNetworkInteractor()),
                                                                      imageInteractor: ConcreteImageInteractor())
    @StateObject private var vmArtistDetails = ArtistDetailsViewModel(artistInteractor: ConcreteArtistInteractor(networkInteractor: ConcreteNetworkInteractor()),
                                                                     imageInteractor: ConcreteImageInteractor())
    @StateObject private var vmAlbumTracks = AlbumTracksViewModel(releasesInteractor: ConcreteReleasesInteractor(networkInteractor: ConcreteNetworkInteractor()))

    var body: some Scene {
        WindowGroup {
            AuthenticationView()
                .environmentObject(vmAuthentication)
                .environmentObject(vmSearchContent)
                .environmentObject(vmArtistDetails)
                .environmentObject(vmAlbumTracks)
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
