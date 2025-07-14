//
//  SearchContentViewModel.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 12/07/25.
//

import Foundation
import UIKit

final class SearchContentViewModel: ObservableObject {

    private let artistInteractor: ArtistInteractor
    private let imageInteractor: ImageInteractor

    private var currentPage = 1
    private var lastQuery = ""

    // MARK: Data
    @Published var results: [SearchItemModel] = []

    // MARK: Loading Indicators
    @Published var loading = true

    // MARK: - Actions definition
    enum Actions {
        case search(String)
    }

    // MARK: - Init
    init(artistInteractor: ArtistInteractor, imageInteractor: ImageInteractor) {
        self.artistInteractor = artistInteractor
        self.imageInteractor = imageInteractor
    }

    // MARK: - Private Methods
    private func getImages(from search: [SearchItemModel]) {
        Task {
            try await withThrowingTaskGroup(of: UIImage?.self) { imageTaskGroup in
                search.compactMap(\.thumbnailURL)
                    .forEach { url in
                        imageTaskGroup.addTask {
                            try await self.imageInteractor.getRemoteImage(url: url)
                        }
                    }
                let asyncSequence = imageTaskGroup.compactMap { $0 }
                for try await _ in asyncSequence { }
            }
        }
    }

    private func search(_ query: String) {
        Task {
            guard lastQuery != query else {
                return
            }
            await MainActor.run {
                self.loading = true
            }
            let response = try await artistInteractor.searchArtist(artist: query, page: currentPage)

            switch response {
            case .success(let searchDetails):
                let newRecords = (searchDetails.results ?? []).compactMap { result in
                    SearchItemModel(searchDTO: result)
                }
                currentPage = searchDetails.pagination?.page ?? 0
                lastQuery = query
                getImages(from: newRecords)

                await MainActor.run {
                    self.loading = false
                    currentPage = searchDetails.pagination?.page ?? 0
                    results = newRecords
                }
            case .failure(let error):
                await MainActor.run {
                    Debug.eval { print("No Data, reason: \(error)") }
                    self.loading = false
                }
            }
        }
    }

    func performAction(_ action: Actions) {
        switch action {
        case .search(let query):
            search(query)
        }
    }


    func getLocalImage(_ url: URL?) -> UIImage? {
        imageInteractor.getImageLocally(url: url)
    }
}
