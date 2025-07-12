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
        VStack {
            Text("Clara Mobile Challenge")
                .customHeaderStyle()
            Button(action: {
                self.authenticationViewModel.performAction(.authenticate)
            }) {
                Text("Login")
            }
        }.padding(.horizontal, 1.su)
    }
}

#Preview {
    LoginView()
}
