//
//  AlbumTracksViewModel.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 13/07/25.
//

import Foundation

final class AlbumTracksViewModel: ObservableObject {
    private let releasesInteractor: ReleasesInteractor

    // MARK: - Data
    @Published var albumDetails: ReleaseDetailsModel?
    @Published var presentDismissAlert: Bool = false

    // MARK: Loading Indicators
    @Published var loading = false

    enum Actions {
        case getAlbumDetails(Int)
    }

    // MARK: - Initialization
    init(releasesInteractor: ReleasesInteractor) {
        self.releasesInteractor = releasesInteractor
    }

    func dismiss() {
        presentDismissAlert = true
    }

    func performAction(_ action: Actions) {
        switch action {
        case .getAlbumDetails(let id):
            getAlbumDetails(id: id)
        }
    }

    // MARK: - Private Methods
    private func getAlbumDetails(id: Int) {
        Task {
            await MainActor.run {
                albumDetails = nil
                loading = true
            }

            let response = try await releasesInteractor.getReleaseDetails(with: id)
            switch response {
            case .success(let details):
                let response: ReleaseDetailsModel = .init(releaseDetailsDTO: details)
                await MainActor.run {
                    loading = false
                    albumDetails = response
                }
            case .failure(let error):
                print(error)
                await MainActor.run {
                    loading = false
                    dismiss()
                }
            }
        }
    }

}
