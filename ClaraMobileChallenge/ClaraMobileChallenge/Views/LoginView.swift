//
//  LoginView.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 12/07/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel

    var body: some View {

        Image(.discogs)
            .resizable(resizingMode: .stretch)
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea()

        VStack {
            Text("Discogs")
                .customTitleStyle()
            Text("Please log in with your credentials to start browsing the discography")
                .customHeaderStyle()
                .padding(.horizontal, 1.su)
                .padding(.bottom, 2.su)
            Button(action: {
                self.authenticationViewModel.performAction(.authenticate)
            }) {
                Text("Login")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(.horizontal, 1.su)
    }
}

#Preview {
    LoginView()
}
