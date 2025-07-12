//  ClaraMobileChallenge
//  Created by Emmanuel Texis
//
// ### Keychain items
// https://developer.apple.com/documentation/security/keychain_services
//

import Foundation

struct Credentials {
    var username: String
    var credentials: String
}

enum KeychainError: Error {
    case noPasswordFound
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}

final class CredentialManager {
    
    static func addCredentialsToKeychain(credentials: Credentials) throws {
        let query: [String : Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: credentials.username,
            kSecValueData as String: credentials.credentials.data(using: .utf8) ?? Data()
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        
        guard status == errSecSuccess
        else { throw KeychainError.unhandledError(status: status)}
    }
    
    static func recoverUserCredentials(username: String) throws -> Credentials {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
            kSecAttrAccount as String: username
        ]
        
        var typeRefItem: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &typeRefItem)
        
        guard status != errSecItemNotFound
        else { throw KeychainError.noPasswordFound }
        
        guard status == errSecSuccess
        else { throw KeychainError.unhandledError(status: status)}
        
        guard
            let existingItem = typeRefItem as? [String: Any],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let credentials = String(data: passwordData, encoding: .utf8),
            let username = existingItem[kSecAttrAccount as String] as? String
        else { throw KeychainError.unexpectedPasswordData }
        
        return .init(username: username, credentials: credentials)
    }
    
    static func updateCurrentCredentials(newCredentials credentials: Credentials) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
        ]
        
        let account = credentials.username
        let credentials = credentials.credentials.data(using: String.Encoding.utf8)!
        let attributes: [String : Any] = [
            kSecAttrAccount as String: account,
            kSecValueData as String: credentials
        ]
        
        let status = SecItemUpdate(
            query as CFDictionary,
            attributes as CFDictionary
        )
        
        guard status != errSecItemNotFound
        else { throw KeychainError.noPasswordFound }
        
        guard status == errSecSuccess 
        else { throw KeychainError.unhandledError(status: status) }
    }
    
    static func deleteUserCredentials(username: String) throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: username,
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound 
        else { throw KeychainError.unhandledError(status: status) }
    }
    
    static func hasUserCredentials(username: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
            kSecAttrAccount as String: username,
        ]
        
        let status = SecItemCopyMatching(query as CFDictionary, nil)
        
        // Validate QUERY matching dont return an error
        
        guard status != errSecItemNotFound
        else { 
            Debug.eval { print("\(#function)-\(#line): noPasswordFound") }
            return false
        }
        
        guard status == errSecSuccess
        else {
            Debug.eval { print("\(#function)-\(#line): noPasswordFound") }
            return false
        }
        
        return true
    }
}
