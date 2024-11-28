//
//  MockMoviesUseCase.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 28/11/2024.
//
import XCTest
import Combine
@testable import SwiftUICombine

class MockMoviesUseCase: MoviesUseCaseContract {
    
    var shouldReturnError: Bool = false
    
    func executeGenres() -> AnyPublisher<GenreResponse, Error> {
        if shouldReturnError {
            return Fail(error: NSError(domain: "", code: 0, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        let mockGenres = GenreResponse(genres: [
            GenreItem( id: 1, name: "Action"),
            GenreItem( id: 2, name: "Comedy"),
        ])
        return Just(mockGenres)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    func executeMovies(with genreId: Int?, and page: Int) -> AnyPublisher<MoviesResponse, Error> {
        if shouldReturnError {
            return Fail(error: NSError(domain: "", code: 0, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        let mockMovies = MoviesResponse(totalPages: 5, results: [
            MovieItem(id: 1, posterPath: "/path1", releaseDate: "2023-01-01", title: "Movie 1"),
            MovieItem(id: 2, posterPath: "/path2", releaseDate: "2023-02-01", title: "Movie 2")
        ])
        
        return Just(mockMovies)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
