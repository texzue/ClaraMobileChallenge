//
//  AuthenticationView.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 12/07/25.
//

import SwiftUI

struct AuthenticationView: View {

    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel

    var body: some View {
        if authenticationViewModel.isLoggedIn {
            ContentSearcherView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.move(edge: .leading))
        } else {
            LoginView()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .transition(.move(edge: .leading))
        }
    }
}

#Preview {
    AuthenticationView()
        .environmentObject(AuthenticationViewModel(oauthService: .init()))
}
