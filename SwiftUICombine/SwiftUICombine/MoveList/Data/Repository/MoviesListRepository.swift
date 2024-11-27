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
    

    // MARK: - INIT
    init(service: MoviesListServiceContract = MoviesListService()) {
        self.service = service
    }

    // MARK: - REPOSITORIES METHODS
    func fetchGenresList() -> AnyPublisher<[GenreResponse], Error> {
        return service.fetchGenresList()
    }
}
