//
//  AlbumView.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 13/07/25.
//

import SwiftUI

struct CustomAsynkView: View {
    let url: URL?
    let imageInteractor: ImageInteractor

    var body: some View {
        if let image = imageInteractor.getImageLocally(url: url){
            Image(uiImage: image)
                .resizable()
                .foregroundStyle(.labelSecondary)
                .scaledToFill()
                .padding(.all, 3)
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .accessibilityIgnoresInvertColors()
        } else {
            AsyncImage(url: url, content: { _ in }, placeholder: {
                Image(systemName: "person.fill.questionmark")
                    .resizable()
                    .foregroundStyle(.labelSecondary)
                    .scaledToFit()
                    .padding(.all, 3)
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .accessibilityIgnoresInvertColors()
            })
            .scaledToFill()
            .frame(width: 80, height: 80)
            .shadow(radius: 2)
            .background(Color.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

#Preview {
    CustomAsynkView(url: .init(string: "https://foo.com"), imageInteractor: PreviewImageInteractor(timeOutInterval: 1))
}
