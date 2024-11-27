//
//  MoviesListServiceContract.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//


import Foundation
import Combine

protocol MoviesListServiceContract {
    func fetchGenresList() -> AnyPublisher<[GenreResponse], Error>
}
