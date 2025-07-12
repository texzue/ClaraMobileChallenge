//
//  ScoreCell.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 12/07/25.
//

import SwiftUI

struct ScoreCell: View {

    var title: String
    var subtitle: String
    var imageURL: URL?

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
            Image(systemName: "person.fill.questionmark")
                .resizable()
                .foregroundStyle(.labelSecondary)
                .scaledToFit()
                .padding(.all, 3)
                .frame(width: 50)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .accessibilityIgnoresInvertColors()
        }
    }
}

#Preview {
    ScoreCell(title: "Example", subtitle: "subExample", imageURL: nil)
}
