//
//  MoviesListEndpoint.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//


import Foundation

enum MoviesListEndpoint: APIEndpoint {
        
    case fetchGenresList
    
    var apiKey: String {API.APIKey}
    var scheme: String {API.scheme}
    var host: String {API.URL}
    public var baseURL: URL {
        return URL(
            string: scheme + "://" + host + path
        )!
    }
   

    public var path: String {
        switch self {
        case .fetchGenresList:
            return "genre/movie/list?api_key=\(apiKey)"
        }
    }

    public var method: HTTPMethod {
        switch self {
        case .fetchGenresList:
            return .get
        }
    }
    
    public var headers: [String: String]? {
        var headers: [String: String] = [:]
        headers["accept"] = "application/json"
        headers["Authorization"] = API.APIKey
        return headers
    }

    public var body: Data? {
        switch self {
        case .fetchGenresList:
            return nil
        }
    }
}



