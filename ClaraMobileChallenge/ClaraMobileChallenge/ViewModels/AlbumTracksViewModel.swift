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
    @Published var loading = true

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
            albumDetails = nil
            getAlbumDetails(id: id)
        }
    }

    // MARK: - Private Methods
    private func getAlbumDetails(id: Int) {
        Task {
            await MainActor.run {
                self.loading = true
            }

            let response = try await releasesInteractor.getReleaseDetails(with: id)
            switch response {
            case .success(let details):
                let response: ReleaseDetailsModel = .init(releaseDetailsDTO: details)
                await MainActor.run {
                    self.loading = false
                    albumDetails = response
                }
            case .failure:
                await MainActor.run {
                    self.loading = false
                    dismiss()
                }
            }
        }
    }

}
