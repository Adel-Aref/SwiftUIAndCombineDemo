//
//  MovieDetailsViewModelTests.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 01/12/2024.
//

import XCTest
import Combine
@testable import SwiftUICombine

class MovieDetailsViewModelTests: XCTestCase {
    
    var viewModel: MovieDetailsViewModel!
    var mockUseCase: MockMovieDetailsUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockUseCase = MockMovieDetailsUseCase(shouldReturnError: false)
        viewModel = MovieDetailsViewModel(useCase: mockUseCase)
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = nil
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }
    
    func test_titleAndYear_shouldReturnCorrectFormattedTitleAndYear() {
        // Given

        let mockMovieDetailsResponse = MovieDetailsResponse(
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

        let movieDetails = MovieDetailsVM(from: mockMovieDetailsResponse)
        viewModel.movieDetailsVM = movieDetails
        
        // When
        let result = viewModel.titleAndYear
        
        // Then
        XCTAssertEqual(result, "Inception (2010)")
    }
    
    func test_getMovieDetails_shouldFetchMovieDetailsSuccessfully() {
        // Given
        let expectation = self.expectation(description: "Movie details should be fetched successfully")
        
        mockUseCase.shouldReturnError = false
        
        // When
        viewModel.$movieDetailsVM
            .dropFirst() // Skip the initial nil value
            .sink { movieDetails in
                // Then
                XCTAssertEqual(movieDetails?.title, "Inception")
                XCTAssertEqual(movieDetails?.releaseYear, "2010")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        viewModel.getMovieDetails(with: 1)
        
        // Wait for the expectations to be fulfilled
        waitForExpectations(timeout: 2, handler: nil)
        
        XCTAssertEqual(self.viewModel.state, .successful)

    }

}

