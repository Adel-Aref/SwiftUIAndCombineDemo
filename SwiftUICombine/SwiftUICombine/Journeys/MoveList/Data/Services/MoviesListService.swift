//
//  MoviesListService.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import Foundation
import Combine

final class MoviesListService: DisposeObject, MoviesListServiceContract {
    private var apiClient = URLSessionAPIClient<MoviesListEndpoint>()

    init(apiClient: any APIContract = URLSessionAPIClient<MoviesListEndpoint>() ) {
        self.apiClient = apiClient as! URLSessionAPIClient<MoviesListEndpoint>
    }
    
    func fetchGenresList() -> AnyPublisher<GenreResponse, Error> {
        return apiClient.request(.fetchGenresList, responseModel: GenreResponse.self)
    }
    
    func fetchMoviesList(with genreID: Int? = nil, and page: Int) -> AnyPublisher<MoviesResponse, Error> {
        return apiClient.request(.fetchMoviesList(genreID: genreID, page: page), responseModel: MoviesResponse.self)
    }
}
