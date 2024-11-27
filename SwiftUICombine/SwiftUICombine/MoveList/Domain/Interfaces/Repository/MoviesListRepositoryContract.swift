//
//  MoviesListRepositoryContract.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import Combine

protocol MoviesListRepositoryContract {
    func fetchGenresList() -> AnyPublisher<[GenreResponse], Error>
}
