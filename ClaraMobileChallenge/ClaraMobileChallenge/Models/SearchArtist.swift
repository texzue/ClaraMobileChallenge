//  ClaraMobileChallenge
//  Created by ETS on 10/07/25.

import Foundation

struct SearchArtist: Codable {
    let pagination: Pagination
    let results: [Artist]
}
