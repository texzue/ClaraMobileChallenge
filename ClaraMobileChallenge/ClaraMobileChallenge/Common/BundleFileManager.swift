//
//  BundleFileManager.swift
//  ClaraMobileChallenge
//
//  Created by Emmanuel Texis Suárez on 12/07/25.
//

import Foundation

final class BundleFileManager {
    init() { }

    static func loadDataFromFile<DTO: Decodable>(from fileName: String) throws -> DTO {
        let url = Bundle.main.url(forResource: fileName, withExtension: "json")!

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(DTO.self, from: data)
    }
}
