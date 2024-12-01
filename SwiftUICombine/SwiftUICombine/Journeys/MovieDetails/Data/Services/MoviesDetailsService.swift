//
//  MoviesDetailsService.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import Foundation
import Combine

final class MoviesDetailsService: DisposeObject, MoviesDetailsServiceContract {
    
    private var apiClient = URLSessionAPIClient<MoviesDetailsEndpoint>()

    init(apiClient: any APIContract = URLSessionAPIClient<MoviesDetailsEndpoint>() ) {
        self.apiClient = apiClient as! URLSessionAPIClient<MoviesDetailsEndpoint>
    }
    
    func fetchMoviesDetails(with id: Int) -> AnyPublisher<MovieDetailsResponse, any Error> {
        return apiClient.request(.fetchMoviesDetails(id: id), responseModel: MovieDetailsResponse.self)
    }
}
