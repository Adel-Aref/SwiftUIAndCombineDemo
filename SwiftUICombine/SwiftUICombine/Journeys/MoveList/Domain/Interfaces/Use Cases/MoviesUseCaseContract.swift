//
//  MoviesUseCaseContract.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//
import Combine
protocol MoviesUseCaseContract {
    func executeGenres() -> AnyPublisher<GenreResponse, Error>
    func executeMovies(with genreID: Int?, and page: Int) -> AnyPublisher<MoviesResponse, Error>
}
