//
//  MoviesDetailsRepository.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import Foundation
import Combine

final class MoviesDetailsRepository: MoviesDetailsRepositoryContract {
    
    var service: MoviesDetailsServiceContract
    
    // MARK: - INIT
    init(service: MoviesDetailsServiceContract = MoviesDetailsService()) {
        self.service = service
    }
    
    func fetchMoviesDetails(id: Int) -> AnyPublisher<MovieDetailsResponse, any Error> {
        service.fetchMoviesDetails(with: id)
    }
}
