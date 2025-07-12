//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import SwiftUI

public enum CustomButtonAction: Equatable {
    case actionId(_ action: String)
    case noAction
}

struct RoundButton: View {

    let id: String
    var subId: String? = nil
    let title: LocalizedStringKey
    var image: Image? = nil
    @Binding var performAction: CustomButtonAction

    var body: some View {
        Button(action: {
            Debug.eval { print(id + (subId != nil ? "-" + (subId ?? "") : "")) }
            performAction = .actionId(id + (subId != nil ? "-" + (subId ?? "") : ""))
        }, label: {
            if image == nil {
                Spacer()
            }
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.vertical, 3)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .frame(height: 33)

            if let image {
                Spacer()
                image
            } else {
                Spacer()
            }
        })
        .buttonStyle(.bordered)
        .tint(.accent)
    }
}

#Preview {
    VStack {
        RoundButton(
            id: "action",
            title: "Example",
            image: .init(systemName: "rainbow"),
            performAction: .constant(.noAction)
        )
        RoundButton(
            id: "action",
            title: "Button Example",
            performAction: .constant(.noAction)
        )

        HStack {
            RoundButton(
                id: "action",
                title: "Button Example",
                performAction: .constant(.noAction)
            )
            RoundButton(
                id: "action",
                title: "Long Label Button Example",
                performAction: .constant(.noAction)
            )
        }
    }
    .padding(.horizontal, 10)
}
