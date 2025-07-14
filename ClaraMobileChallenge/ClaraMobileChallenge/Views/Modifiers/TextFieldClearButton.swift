//
//  TextFieldClearButton.swift
//  ClaraMobileChallenge
//
//  Created by alice on 14/07/25.
//


import SwiftUI

struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(Color(UIColor.opaqueSeparator))
                    }
                )
                .padding(.horizontal)
            }
        }
    }
}
