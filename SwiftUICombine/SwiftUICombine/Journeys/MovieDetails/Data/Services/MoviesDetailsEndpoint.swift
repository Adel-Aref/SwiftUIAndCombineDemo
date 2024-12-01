//
//  MoviesDetailsEndpoint.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//


import Foundation

enum MoviesDetailsEndpoint: APIEndpoint {
    
    case fetchMoviesDetails(id: Int)
    
    var apiKey: String {API.APIKey}
    var scheme: String {API.scheme}
    var host: String {API.URL}
    public var baseURL: URL {
        return URL(
            string: scheme + "://" + host
        )!
    }
    
    
    public var path: String {
        switch self {
        case .fetchMoviesDetails(let id):
            return "movie/\(id)"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .fetchMoviesDetails:
            return .get
        }
    }
    
    public var headers: [String: String]? {
        var headers: [String: String] = [:]
        headers["accept"] = "application/json"
        headers["Authorization"] = API.APIKey
        return headers
    }
    
    public var queryParameters: [String: String] {
        var params: [String: String] = [:]
        params["api_key"] = apiKey
        params["language"] = "en-US"
        switch self {
        case .fetchMoviesDetails(let id):
            return params
        }
        return params
    }
    
    public var body: Data? {
        switch self {
        case .fetchMoviesDetails:
            return nil
        }
    }
}



