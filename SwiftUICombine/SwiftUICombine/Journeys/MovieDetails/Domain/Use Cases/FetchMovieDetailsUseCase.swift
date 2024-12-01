//
//  FetchMoviesUseCase.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import Foundation
import Combine
import CoreModule

final class FetchMovieDetailsUseCase: DisposeObject, MovieDetailsUseCaseContract {
    
    // MARK: - PROPERTIES
    private let repository: MoviesDetailsRepositoryContract

    // MARK: - INIT
    init(repository: MoviesDetailsRepositoryContract = MoviesDetailsRepository()) {
        self.repository = repository
        super.init()
    }
    
    func executeMovies(with id: Int) -> AnyPublisher<MovieDetailsResponse, Error> {
        return repository.fetchMoviesDetails(id: id)
    }
}
