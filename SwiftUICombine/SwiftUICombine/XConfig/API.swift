//
//  API.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 01/12/2024.
//

import Foundation

struct API {
    static var APIKey: String { PlistEnvironment.APIKey }
    static var privateKey: String { "Enter your PRIVATE KEY" }
    static var timeStamp: String { formatter.string(from: Date()) }
    static var schemeURL: String {scheme + "://" + URL}
    static var scheme: String {
        return PlistEnvironment.scheme
    }
    static var URL: String {
        PlistEnvironment.baseURL
    }
    
    private static let formatter: DateFormatter = {
        let form = DateFormatter()
        form.dateFormat = "yyyyMMddHHmmss"
        return form
    }()
}
