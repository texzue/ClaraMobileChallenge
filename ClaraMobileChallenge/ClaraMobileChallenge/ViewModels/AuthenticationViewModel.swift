//
//  AuthenticationViewController.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 12/07/25.
//

import Foundation

public enum AuthenticationViewAction: String {
    case authenticate
}

final class AuthenticationViewModel: ObservableObject {

    private let oauthService: OauthAuthenticator

    // MARK: Loading Indicators
    @Published var error: String?

    // MARK: Navigation
    @Published var isLoggedIn = false

    init(oauthService: OauthAuthenticator) {
        self.oauthService = oauthService
    }

    func performAction(_ action: AuthenticationViewAction) {
        switch action {
        case .authenticate:
            Task {
                let response = try await oauthService.autenticate()
                await MainActor.run {
                    switch response {
                    case .success:
                        isLoggedIn = true
                    case .failure:
                        error = "oath_authentication_error"
                    }
                }
            }
        }
    }
}
