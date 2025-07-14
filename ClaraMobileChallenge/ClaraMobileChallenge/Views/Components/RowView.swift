//
//  RowView.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 13/07/25.
//

import SwiftUI

struct RowView: View {
    let title: String
    let subtitle: String
    let isVertical: Bool
    let smallDescription: Bool

    init(title: String, subtitle: String, isVertical: Bool = false, smallDescription: Bool = false) {
        self.title = title
        self.subtitle = subtitle
        self.isVertical = isVertical
        self.smallDescription = smallDescription
    }

    var body: some View {
        if isVertical {
            VStack(alignment: .leading) {
                Text(title).customHeaderStyle()
                if smallDescription {
                    Text(subtitle).customContentStyle().multilineTextAlignment(.leading)
                } else {
                    Text(subtitle).customSubHeaderStyle().multilineTextAlignment(.leading)
                }
            }
        } else {
            HStack {
                Text(title).customHeaderStyle()
                Spacer()
                if smallDescription {
                    Text(subtitle).customContentStyle()
                }
                else {
                    Text(subtitle).customSubHeaderStyle()
                }
            }
        }
    }
}

#Preview {
    RowView(title: "Example", subtitle: "Subtitle", isVertical: false, smallDescription: false)
}
