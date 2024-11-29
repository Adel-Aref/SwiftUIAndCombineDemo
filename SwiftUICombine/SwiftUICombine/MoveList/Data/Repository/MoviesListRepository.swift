//
//  MoviesListRepository.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import Foundation
import Combine

final class MoviesListRepository: MoviesListRepositoryContract {
    var service: MoviesListServiceContract
    var localDataSource: MoviesListLocalDataSourceContract
    
    // MARK: - INIT
    init(service: MoviesListServiceContract = MoviesListService(),
         localDataSource: MoviesListLocalDataSourceContract = MoviesListLocalDataSource()) {
        self.service = service
        self.localDataSource = localDataSource
    }
    
    // MARK: - REPOSITORY METHODS
    func fetchGenresList() -> AnyPublisher<GenreResponse, Error> {
        // 1. Check for cached data and return immediately if available.
        if let cachedGenres = localDataSource.getCachedGenres() {
            // 2. Return cached data right away, but still perform the fetch to update the cache.
            _ = service.fetchGenresList()
                .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] response in
                    self?.localDataSource.cacheGenres(response)
                })
            return Just(cachedGenres)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            // 3. If no cached data, fetch from remote and cache the result.
            return service.fetchGenresList()
                .handleEvents(receiveOutput: { [weak self] response in
                    self?.localDataSource.cacheGenres(response)
                })
                .eraseToAnyPublisher()
        }
    }
    
    func fetchMoviesList(with genreId: Int?, and page: Int) -> AnyPublisher<MoviesResponse, Error> {
        if let cachedMovies = localDataSource.getCachedMovies(for: genreId, page: page) {
            _ = service.fetchMoviesList(with: genreId, and: page)
                .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] response in
                    self?.localDataSource.cacheMovies(response, for: genreId, page: page)
                })
            return Just(cachedMovies)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return service.fetchMoviesList(with: genreId, and: page)
                .handleEvents(receiveOutput: { [weak self] response in
                    self?.localDataSource.cacheMovies(response, for: genreId, page: page)
                })
                .eraseToAnyPublisher()
        }
    }
}
