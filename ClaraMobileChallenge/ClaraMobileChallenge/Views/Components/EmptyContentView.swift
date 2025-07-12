//
//  EmtyContentView.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 12/07/25.
//

import SwiftUI

struct EmptyContentView: View {
    @Binding var query: String

    var body: some View {
        VStack {
            Image(systemName: "text.magnifyingglass")
                .resizable()
                .foregroundStyle(.labelSecondary)
                .scaledToFit()
                .padding(.all, 2)
                .frame(width: 6.su)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .accessibilityIgnoresInvertColors()

            if query.isEmpty  {
                Text("No results")
                    .customBoldHeaderStyle()
                    .padding(.top, 1.su)
                Text("Try a new search")
                    .customSubHeaderStyle()
                    .padding(.top, 1)
            } else {
                Text("No results for \(query)")
                    .customBoldHeaderStyle()
                    .padding(.top, 1.su)
                Text("Check spelling or try a new search")
                    .customSubHeaderStyle()
                    .padding(.top, 1)
            }
        }
        .padding(.horizontal, 3.su)
    }
}

#Preview {
    EmptyContentView(query: .constant("User"))
}
