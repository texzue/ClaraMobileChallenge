//
//  AlbumView.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 13/07/25.
//

import SwiftUI

struct CustomAsynkView: View {
    @Binding var url: URL?
    let imageInteractor: ImageInteractor

    var body: some View {
        if let image = imageInteractor.getImageLocally(url: url){
            Image(uiImage: image)
                .resizable()
                .foregroundStyle(.labelSecondary)
                .scaledToFill()
                .padding(.all, 3)
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .accessibilityIgnoresInvertColors()
        } else {
            AsyncImage(url: url, transaction: Transaction(
                animation: .spring(
                    response: 0.5,
                    dampingFraction: 0.65,
                    blendDuration: 0.125)
            )) { phase in
                switch phase {
                case .success(let image):
                    image
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .background(.red.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .accessibilityIgnoresInvertColors()
                case .empty, .failure:
                    Image(systemName: "person.fill.questionmark")
                        .resizable()
                        .foregroundStyle(.labelSecondary)
                        .scaledToFit()
                        .padding(.all, 15)
                        .frame(width: 80, height: 80)
                @unknown default:
                    ProgressView()
                }
            }
        }
    }
}

#Preview {
    CustomAsynkView(url: .constant(.init(string: "https://i.discogs.com/wfLvmAj3er8_Zdg-jJnmdzC-XxtMQZ04h6kuIZKIE-8/rs:fit/g:sm/q:40/h:150/w:150/czM6Ly9kaXNjb2dz/LWRhdGFiYXNlLWlt/YWdlcy9SLTMwODM1/ODAzLTE3MjUwMzkz/NzgtNzU1OC5qcGVn.jpeg")), imageInteractor: PreviewImageInteractor(timeOutInterval: 0))
}
