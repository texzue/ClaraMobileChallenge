//
//  ResponseItem.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 13/07/25.
//

import Foundation

struct SearchItemModel: ViewModel, Identifiable {
    private let result: SearchDTO.Results

    init(searchDTO: SearchDTO.Results) {
        self.result = searchDTO
    }

    // MARK: - Computed Properties

    var id: Int {
        result.id
    }

    var identifier: String {
        String(result.id)
    }

    var thumbnailURL: URL? {
        getURL(result.thumb)
    }

    var name: String {
        result.title ?? "NA"
    }
}
