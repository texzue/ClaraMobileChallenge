//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

final class PreviewArtistInteractor: ArtistInteractor {

    var returnErrorEnabled: Bool
    var networkErrorToReturn: NetworkError

    init(returnErrorEnabled: Bool, networkErrorToReturn: NetworkError) {
        self.returnErrorEnabled = returnErrorEnabled
        self.networkErrorToReturn = networkErrorToReturn
    }

    func searchArtist(artist: String, page: Int) async throws -> Result<Search, NetworkError> {
        let data: Search = try loadDataFromFile(from: "preview_main_search")

        return returnErrorEnabled
        ? .failure(networkErrorToReturn)
        : .success(data)
    }
    
    func getArtistDetails(with id: Int) async throws -> Result<Artist, NetworkError> {
        let data: Artist = try loadDataFromFile(from: "preview_search_artist")

        return returnErrorEnabled
        ? .failure(networkErrorToReturn)
        : .success(data)
    }
    
    func getArtistReleases(artistId: Int, page: Int) async throws -> Result<Releases, NetworkError> {
        let data: Releases = try loadDataFromFile(from: "preview_search_release")

        return returnErrorEnabled
        ? .failure(networkErrorToReturn)
        : .success(data)
    }
    
    private func loadDataFromFile<DTO: Decodable>(from fileName: String) throws -> DTO {
        let url = Bundle.main.url(forResource: fileName, withExtension: "json")!

        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(DTO.self, from: data)
    }
}
