//
//  MoviesListServiceContract.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//


import Foundation
import Combine

protocol MoviesListServiceContract {
    func fetchGenresList() -> AnyPublisher<GenreResponse, Error>
    func fetchMoviesList(with genreID: Int?, and page: Int) -> AnyPublisher<MoviesResponse, Error>
}
