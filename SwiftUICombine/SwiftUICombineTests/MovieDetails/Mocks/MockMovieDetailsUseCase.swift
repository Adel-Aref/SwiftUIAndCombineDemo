//
//  MockMovieDetailsUseCase.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 01/12/2024.
//
import XCTest
import Combine
@testable import SwiftUICombine


class MockMovieDetailsUseCase: MovieDetailsUseCaseContract {
    var shouldReturnError: Bool = false

    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
    func executeMovies(with id: Int) -> AnyPublisher<MovieDetailsResponse, Error> {
        let mockMovieDetails = MovieDetailsResponse(
            id: 1,
            title: "Inception",
            posterPath: "/inception.jpg",
            releaseDate: "2010-07-16",
            genres: [
                Genre(id: 28, name: "Action"),
                Genre(id: 878, name: "Science Fiction")
            ],
            overview: "A mind-bending thriller about dreams within dreams.",
            homepage: "https://www.warnerbros.com/inception",
            budget: 160000000,
            revenue: 830000000,
            spokenLanguages: [
                SpokenLanguage(englishName: "English", iso6391: "en", name: "English"),
                SpokenLanguage(englishName: "Japanese", iso6391: "ja", name: "Japanese")
            ],
            status: "Released",
            runtime: 148
        )
        if shouldReturnError {
            return Fail(error: NSError(domain: "", code: 0, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        return Just(mockMovieDetails)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
