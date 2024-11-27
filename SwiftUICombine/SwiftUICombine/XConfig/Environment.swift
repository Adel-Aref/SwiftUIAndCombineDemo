//
//  Environment.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 14/11/2024.
//

import Foundation

public enum PlistEnvironment {
    // MARK: - Keys
        enum PlistKeys {
            static let baseURL = "Base_URL"
            static let appName = "APP_NAME"
            static let scheme = "Scheme"
            static let APIKey = "API_Key"
        }

    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    // MARK: - Plist values
    static let baseURL: String = {
        guard let baseURLstring = PlistEnvironment.infoDictionary[PlistKeys.baseURL] as? String else {
            fatalError("base baseURL not set in plist for this environment")
        }
        guard let url = URL(string: baseURLstring) else {
            fatalError("Base baseURL is invalid")
        }
        return baseURLstring
    }()

    static let appName: String = {
        guard let appNameURLstring = PlistEnvironment.infoDictionary[PlistKeys.appName] as? String else {
            fatalError("registration appName not set in plist for this environment")
        }
        guard let url = URL(string: appNameURLstring) else {
            fatalError("Registration appName is invalid")
        }
        return appNameURLstring
    }()
    
    static let scheme: String = {
        guard let schemeURLstring = PlistEnvironment.infoDictionary[PlistKeys.scheme] as? String else {
            fatalError("registration scheme not set in plist for this environment")
        }
        guard let url = URL(string: schemeURLstring) else {
            fatalError("Registration scheme is invalid")
        }
        return schemeURLstring
    }()
    
    static let APIKey: String = {
        guard let keyURLstring = PlistEnvironment.infoDictionary[PlistKeys.APIKey] as? String else {
            fatalError("registration APIKey not set in plist for this environment")
        }
        guard let url = URL(string: keyURLstring) else {
            fatalError("Registration APIKey is invalid")
        }
        return keyURLstring
    }()
}
