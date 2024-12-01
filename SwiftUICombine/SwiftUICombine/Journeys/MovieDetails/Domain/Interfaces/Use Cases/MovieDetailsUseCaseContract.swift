//
//  MovieDetailsUseCaseContract.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//
import Combine
protocol MovieDetailsUseCaseContract {
    func executeMovies(with id: Int) -> AnyPublisher<MovieDetailsResponse, Error>
}
