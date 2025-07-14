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

        VStack(alignment: .trailing) {

            Image(.discogs)
                .resizable(resizingMode: .stretch)
                .aspectRatio(contentMode: .fill)
                .frame(maxHeight: 400)
                .clipped()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()

            HStack {
                Text("Discogs")
                    .customTitleStyle()
                Spacer()
            }
            .padding(.horizontal, 2.su)
            Text("Please log in with your credentials to start browsing the discography")
                .customHeaderStyle()
                .padding(.horizontal, 2.su)
                .padding(.bottom, 2.su)
            Button(action: {
                self.authenticationViewModel.performAction(.authenticate)
            }) {
                Text("Login")
                    .font(.title.bold().monospaced())
            }
            .foregroundStyle(.buttonLabel)
            .buttonStyle(.borderedProminent)
            .padding(.horizontal, 1.su)
            Spacer()
        }
        .background(.contentBackground)
    }
}

#Preview {
    LoginView()
}
