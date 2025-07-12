//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import SwiftUI

fileprivate struct TitleLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title.weight(.heavy).monospaced())
            .foregroundStyle(.labelPrimary)
            .minimumScaleFactor(0.5.su)
            .padding(.top, 1.su)
    }
}

fileprivate struct BoldHeaderLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title3.weight(.bold).monospaced())
            .foregroundStyle(.labelPrimary)
            .minimumScaleFactor(0.5)
            .padding(.top, 1.su)
    }
}

fileprivate struct HeaderLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline.weight(.semibold).monospaced())
            .foregroundStyle(.labelPrimary)
            .minimumScaleFactor(0.5)
            .padding(.top, 1.su)
    }
}


fileprivate struct SubHeaderLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline.weight(.semibold).monospaced())
            .foregroundStyle(.labelSecondary)
            .minimumScaleFactor(0.5)
            .padding(.top, 1.su)
    }
}

fileprivate struct DefaultLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.body.weight(.regular))
            .foregroundStyle(.labelPrimary)
            .minimumScaleFactor(0.5)
            .padding(.top, 1.su)
    }
}

extension Label {
    func customHeaderStyle() -> some View {
        modifier(HeaderLabel())
    }

    func customBoldHeaderStyle() -> some View {
        modifier(BoldHeaderLabel())
    }

    func customSubHeaderStyle() -> some View {
        modifier(SubHeaderLabel())
    }

    func customTitleStyle() -> some View {
        modifier(TitleLabel())
    }

    func customContentStyle() -> some View {
        modifier(DefaultLabel())
    }
}

extension Text {
    func customHeaderStyle() -> some View {
        modifier(HeaderLabel())
    }

    func customBoldHeaderStyle() -> some View {
        modifier(BoldHeaderLabel())
    }

    func customSubHeaderStyle() -> some View {
        modifier(SubHeaderLabel())
    }

    func customTitleStyle() -> some View {
        modifier(TitleLabel())
    }

    func customContentStyle() -> some View {
        modifier(DefaultLabel())
    }
}

#Preview {
    VStack {
        Spacer()
        Text("preview_title").customTitleStyle()
        Text("preview_title").customBoldHeaderStyle()
        Text("preview_header").customHeaderStyle()
        Text("preview_subheader").customSubHeaderStyle()
        Text("preview_content").customContentStyle()
        Spacer()
    }
    .background(Color.contentBackground)
}
