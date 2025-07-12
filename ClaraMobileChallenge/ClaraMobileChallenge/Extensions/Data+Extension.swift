//  ClaraMobileChallenge
//  Created by Emmanuel Texis

import Foundation

extension Data {
    func prettyPrintedJSONString() -> String? {
            do {
                // 1. Attempt to deserialize the Data into a JSON object (e.g., Dictionary or Array).
                //    JSONSerialization automatically handles unescaping characters like '\/' during this step.
                let jsonObject = try JSONSerialization.jsonObject(with: self, options: [])

                // 2. Attempt to re-serialize the JSON object back into Data,
                //    using the .prettyPrinted option for readability.
                //    Because the URLs were unescaped in step 1, they will be written
                //    without the backslashes in the output.
                let prettyPrintedData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)

                // 3. Convert the pretty-printed Data into a String using UTF-8 encoding.
                if let jsonString = String(data: prettyPrintedData, encoding: .utf8) {
                    return jsonString
                } else {
                    print("Error: Could not convert pretty-printed Data to String using UTF-8 encoding.")
                    return nil
                }
            } catch {
                // Handle any errors during JSON serialization or deserialization.
                print("Error pretty printing JSON: \(error.localizedDescription)")
                return nil
            }
        }
}
