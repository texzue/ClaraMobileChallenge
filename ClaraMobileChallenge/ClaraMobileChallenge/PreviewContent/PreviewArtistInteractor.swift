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

    func searchArtist(artist: String, page: Int) async throws -> Result<SearchDTO, NetworkError> {
        let data: SearchDTO = try BundleFileManager.loadDataFromFile(from: "preview_main_search")

        return returnErrorEnabled
        ? .failure(networkErrorToReturn)
        : .success(data)
    }
    
    func getArtistDetails(with id: Int) async throws -> Result<ArtistDTO, NetworkError> {
        let data: ArtistDTO = try BundleFileManager.loadDataFromFile(from: "preview_get_artist")

        return returnErrorEnabled
        ? .failure(networkErrorToReturn)
        : .success(data)
    }
    
    func getArtistReleases(artistId: Int, page: Int) async throws -> Result<ReleasesDTO, NetworkError> {
        let data: ReleasesDTO = try BundleFileManager.loadDataFromFile(from: "preview_get_releases")

        return returnErrorEnabled
        ? .failure(networkErrorToReturn)
        : .success(data)
    }
}
