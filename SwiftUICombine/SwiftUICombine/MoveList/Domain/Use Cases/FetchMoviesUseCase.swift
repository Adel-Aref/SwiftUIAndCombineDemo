//
//  FetchMoviesUseCase.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import Foundation
import Combine

final class FetchMoviesUseCase: DisposeObject, MoviesUseCaseContract {
//    func executeMovies(with genreID: Int?, and page: Int) -> AnyPublisher<MoviesResponse, any Error> {
//        <#code#>
//    }
    
    
    // MARK: - PROPERTIES
    private let repository: MoviesListRepositoryContract

    // MARK: - INIT
    init(repository: MoviesListRepositoryContract = MoviesListRepository()) {
        self.repository = repository
        super.init()
    }

    // MARK: - EXECUTE USE CASE
    func executeGenres() -> AnyPublisher<GenreResponse, Error> {
        return repository.fetchGenresList()
    }
    
    func executeMovies(with genreID: Int?, and page: Int) -> AnyPublisher<MoviesResponse, Error> {
        return repository.fetchMoviesList(with: genreID, and: page)
    }
}
