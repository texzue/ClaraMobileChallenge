//
//  ViewModel.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 13/07/25.
//

import Foundation
import UIKit

protocol ViewModel {
    func getURL(_ uri: String?) -> URL?
    func date(from iso8601String: String) -> Date?
}

extension ViewModel {
    func getURL(_ uri: String?) -> URL? {
        guard let uri else { return nil }

        let pictureURL = uri.replacingOccurrences(of: "\"", with: "")
        return URL(string: pictureURL)
    }

    func date(from iso8601String: String) -> Date?  {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: iso8601String)
    }
}
