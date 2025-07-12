//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

enum ServerResponseCode: Int {
    case Success = 200                  // Requested data is provided in the response body
    case SuccessContinue = 201          // You’ve sent a POST request to a list of resources to create a new one
    case NoContent = 204                // The request was successful, but no data
    case Unauthorized = 400             // You’re attempting to access a resource that first requires authentication
    case AuthenticationRequired = 401   // You’re attempting to access a resource that first requires authentication
    case Forbidden = 403                // You’re not allowed to access this resource. Even if you authenticated
    case NotFound = 404                 // The resource you requested doesn’t exist
    case MethodNotAllowed = 405         // You’re trying to use an HTTP verb that isn’t supported by the resource
    case UnprocessableEntity = 422      // Something semantically wrong with the body of the request. JSON malformed in body
    case InternalServerError = 500
}
