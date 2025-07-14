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
            CustomAsynkView(url: imageURL, imageInteractor: imageInteractor)
        }
    }
}

#Preview {
    ScoreCell( title: "Example", subtitle: "subExample", imageURL: URL(string: "https://foo.go"))
}
