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
        let data: ReleaseDetails = try BundleFileManager.loadDataFromFile(from: "preview_get_release_details")

        return returnErrorEnabled
        ? .failure(networkErrorToReturn)
        : .success(data)
    }
}
