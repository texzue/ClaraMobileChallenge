//
//  ScoreCell.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 12/07/25.
//

import SwiftUI

struct ScoreCell: View {

    let imageInteractor: ImageInteractor = ConcreteImageInteractor()
    var title: String
    var subtitle: String
    var imageURL: URL?

    init(title: String, subtitle: String, imageURL: URL? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                Text(subtitle)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            if let image = imageInteractor.getImageLocally(url: imageURL){
                Image(uiImage: image)
                    .resizable()
                    .foregroundStyle(.labelSecondary)
                    .scaledToFill()
                    .padding(.all, 3)
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .accessibilityIgnoresInvertColors()
            } else {
                AsyncImage(url: imageURL, content: { _ in }, placeholder: {
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
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 2)
            }
        }
    }
}

#Preview {
    ScoreCell( title: "Example", subtitle: "subExample", imageURL: URL(string: "https://foo.go"))
}
