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

    // MARK: Pagination
    private var recordsNextPage = 1
    private var maxPagination = 2
    @Published var noMoreData = false

    // MARK: Data
    private var lastQuery = ""
    @Published var results: [SearchItemModel] = []

    // MARK: Loading Indicators
    @Published var loading = true

    // MARK: - Actions definition
    enum Actions {
        case search(String)
        case loadMoreRecords
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
                recordsNextPage = 1
                self.loading = true
            }
            let response = try await artistInteractor.searchArtist(artist: query, page: recordsNextPage)

            switch response {
            case .success(let searchDetails):
                let newRecords = (searchDetails.results ?? []).compactMap { result in
                    SearchItemModel(searchDTO: result)
                }
                maxPagination = searchDetails.pagination?.pages ?? 1
                lastQuery = query
                getImages(from: newRecords)

                await MainActor.run {
                    recordsNextPage += 1
                    self.loading = false
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
    
    private func loadMoreRecords() {
        guard recordsNextPage <= maxPagination
        else {
            Task {
                await MainActor.run {
                    noMoreData = true
                }
            }
            return
        }
        Task {
            await MainActor.run {
                self.loading = true
            }
            let response = try await artistInteractor.searchArtist(artist: lastQuery, page: recordsNextPage)

            switch response {
            case .success(let searchDetails):
                let newRecords = (searchDetails.results ?? []).compactMap { result in
                    SearchItemModel(searchDTO: result)
                }
                recordsNextPage += 1
                getImages(from: newRecords)

                await MainActor.run {
                    loading = false
                    results += newRecords
                }
            case .failure(let error):
                switch error {
                case .noContent, .general:
                    await MainActor.run {
                        loading = false
                        noMoreData = true
                    }
                default:
                    await MainActor.run {
                        loading = false
                        noMoreData = true
                    }
                }
            }
        }
    }

    func performAction(_ action: Actions) {
        switch action {
        case .search(let query):
            search(query)
        case .loadMoreRecords:
            loadMoreRecords()
        }
    }


    func getLocalImage(_ url: URL?) -> UIImage? {
        imageInteractor.getImageLocally(url: url)
    }
}
