//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

final class PreviewReleasesInteractor: ReleasesInteractor {

    var returnErrorEnabled: Bool
    var networkErrorToReturn: NetworkError

    init(returnErrorEnabled: Bool, networkErrorToReturn: NetworkError) {
        self.returnErrorEnabled = returnErrorEnabled
        self.networkErrorToReturn = networkErrorToReturn
    }

    func getReleaseDetails(with id: Int) async throws -> Result<ReleaseDetails, NetworkError> {
        let data: ReleaseDetails = try loadDataFromFile(from: "preview_get_release_details")

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
