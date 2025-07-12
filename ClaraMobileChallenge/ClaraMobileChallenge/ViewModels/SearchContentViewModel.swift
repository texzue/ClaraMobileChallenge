//
//  SearchContentViewModel.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 12/07/25.
//

import Foundation
import UIKit

public enum SearchContentViewAction {
    case search(String)
}

final class SearchContentViewModel: ObservableObject{

    private let artistInteractor: ArtistInteractor
    private let imageInteractor: ImageInteractor

    private var currentPage = 1
    private var lastQuery = ""

    // MARK: Data
    @Published var results: [Search.Results] = []

    // MARK: Loading Indicators
    @Published var loading = true

    // MARK: Navigation
    @Published var presentArtistDetails = false
    @Published var artistName: String? = nil

    // MARK: - Init
    init(artistInteractor: ArtistInteractor, imageInteractor: ImageInteractor) {
        self.artistInteractor = artistInteractor
        self.imageInteractor = imageInteractor
    }

    // MARK: - Private Methods

    private func getImages(from search: Search) async throws {
        try await withThrowingTaskGroup(of: UIImage?.self) { imageTaskGroup in
            search.results?.compactMap(\.thumbURL)
                .forEach { url in
                    imageTaskGroup.addTask {
                        try await self.imageInteractor.getRemoteImage(url: url)
                    }
                }

            let asyncSequence = imageTaskGroup.compactMap { $0 }
            for try await _ in asyncSequence { }
        }
    }

    func performAction(_ action: SearchContentViewAction) {
        Task {
            switch action {
            case .search(let query):
                guard lastQuery != query else {
                    return
                }
                await MainActor.run {
                    self.loading = true
                }
                let response = try await artistInteractor.searchArtist(artist: query, page: currentPage)
                await MainActor.run {
                    switch response {
                    case .success(let searchDetails):
                        results = searchDetails.results ?? []
                        currentPage = searchDetails.pagination?.page ?? 0
                        Task(priority: .userInitiated) {
                            try? await getImages(from: searchDetails)
                        }
                        lastQuery = query
                    case .failure(let error):
                        Debug.eval { print("No Data, reason: \(error)") }
                    }
                    self.loading = false
                }
            }
        }
    }
}
