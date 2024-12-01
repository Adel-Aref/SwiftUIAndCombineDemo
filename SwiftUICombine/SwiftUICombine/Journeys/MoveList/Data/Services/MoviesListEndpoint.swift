//
//  MoviesListEndpoint.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import Foundation
import CoreModule

enum MoviesListEndpoint: APIEndpoint {
    
    case fetchGenresList
    case fetchMoviesList(genreID: Int?, page: Int)
    
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
        case .fetchGenresList:
            return "genre/movie/list"
        case .fetchMoviesList:
            return "discover/movie"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .fetchGenresList, .fetchMoviesList:
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
        switch self {
        case .fetchMoviesList(let genreID, let page):
            if let genreID = genreID  {
                params["with_genres"] = "\(genreID)"
            }
            params["page"] = "\(page)"
        default :
            return params
        }
        return params
    }
    
    public var body: Data? {
        switch self {
        case .fetchGenresList, .fetchMoviesList:
            return nil
        }
    }
}



