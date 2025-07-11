//
//  Data+Extension.swift
//  ClaraMobileChallenge
//
//  Created by alice on 11/07/25.
//
import Foundation

extension Data {
    var prettyPrintedJSONString: NSString? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: jsonObject,
                                                       options: [.prettyPrinted]),
              let prettyJSON = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
                  return nil
               }

        return prettyJSON
    }
}
