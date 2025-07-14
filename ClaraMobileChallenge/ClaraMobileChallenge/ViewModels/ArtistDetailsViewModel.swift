//
//  ArtistDetailsViewModel.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 13/07/25.
//

import Foundation
import UIKit

final class ArtistDetailsViewModel: ObservableObject {
    private let artistInteractor: ArtistInteractor
    private let imageInteractor: ImageInteractor

    // MARK: Data
    @Published var artistDetails: ArtistModel?
    @Published var artistReleases: [ReleaseModel] = []
    @Published var artistImages: [URL] = []

    private var releasesNextPage = 1

    // MARK: Loading Indicators
    @Published var loading = true

    // MARK: - Alerts
    @Published private var presentDismissAlert = false

    // MARK: - Actions definition
    enum Actions {
        case loadArtistDetails(Int)
        case loadNextRecords(Int)
    }

    // MARK: - Initialization
    init(artistInteractor: ArtistInteractor, imageInteractor: ImageInteractor) {
        self.artistInteractor = artistInteractor
        self.imageInteractor = imageInteractor
    }

    // MARK: - Private Methods
    private func getImages(from search: [ArtistModel?]) {
        let images = search
            .compactMap { artist in artist?.artistImages }
            .flatMap { $0 }
        Task {
            try await withThrowingTaskGroup(of: UIImage?.self) { imageTaskGroup in
                images.forEach { image in
                        imageTaskGroup.addTask {
                            try await self.imageInteractor.getRemoteImage(url: image.url)
                        }
                    }
                let asyncSequence = imageTaskGroup.compactMap { $0 }
                for try await _ in asyncSequence { }
            }
        }
    }

    private func getImages(from search: [ReleaseModel]) {
        let images = search
            .compactMap { release in release.thumbnail }

        Task {
            try await withThrowingTaskGroup(of: UIImage?.self) { imageTaskGroup in
                images.forEach { image in
                        imageTaskGroup.addTask {
                            try await self.imageInteractor.getRemoteImage(url: image.url)
                        }
                    }
                let asyncSequence = imageTaskGroup.compactMap { $0 }
                for try await _ in asyncSequence { }
            }
        }
    }

    func getLocalImage(_ url: URL?) -> UIImage? {
        imageInteractor.getImageLocally(url: url)
    }

    func performAction(_ action: Actions) {
        Task {
            switch action {
            case .loadArtistDetails(let artistId):
                loadArtistDetails(artistId: artistId)
            case .loadNextRecords(let artistId):
                getNextRecord(artistId: artistId)
            }
        }
    }

    func dismiss() {
        presentDismissAlert = true
    }

    private func loadArtistDetails(artistId: Int) {
        releasesNextPage = 1
        Task {
            do {
                await MainActor.run {
                    artistDetails = nil
                    artistReleases = []
                }
                let responseArtist = try await artistInteractor.getArtistDetails(with: artistId)
                switch responseArtist {
                case .success(let artist):
                    let artistModel = ArtistModel(artist: artist)
                    self.getImages(from: [artistDetails])
                    self.getNextRecord(artistId: artistId)
                    await MainActor.run {
                        artistDetails = artistModel
                        artistImages = artist.images?.compactMap { artistImage in
                            getURLFromString(artistImage.uri)
                        } ?? []
                    }
                case .failure:
                    presentDismissAlert = true
                }

            } catch {
                dismiss()
            }
        }
    }

    private func getNextRecord(artistId: Int) {
        Task {
            do {
                let response = try await artistInteractor.getArtistReleases(artistId: artistId, page: releasesNextPage)
                switch response {
                case .success(let releasesResponse):
                    let releases = releasesResponse.releases?.compactMap { releaseDTO in
                        ReleaseModel(release: releaseDTO)
                    } ?? []
                    getImages(from: releases)

                    await MainActor.run {
                        artistReleases = releases
                        releasesNextPage += 1
                    }

                case .failure:
                    presentDismissAlert = true
                }
            } catch {
                dismiss()
            }
        }
    }

    private func getURLFromString(_ url: String?) -> URL? {
        guard let url else { return nil }

        let pictureURL = url.replacingOccurrences(of: "\"", with: "")
        return URL(string: pictureURL)
    }
}
