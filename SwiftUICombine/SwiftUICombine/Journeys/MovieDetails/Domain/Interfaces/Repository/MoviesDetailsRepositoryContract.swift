//
//  MoviesDetailsRepositoryContract.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import Combine

protocol MoviesDetailsRepositoryContract {
    
    func fetchMoviesDetails(id: Int) -> AnyPublisher<MovieDetailsResponse, Error>
}
