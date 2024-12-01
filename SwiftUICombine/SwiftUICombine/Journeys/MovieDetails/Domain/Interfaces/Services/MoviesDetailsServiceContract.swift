//
//  MoviesDetailsServiceContract.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//


import Foundation
import Combine

protocol MoviesDetailsServiceContract {
    func fetchMoviesDetails(with id: Int) -> AnyPublisher<MovieDetailsResponse, Error>
}
