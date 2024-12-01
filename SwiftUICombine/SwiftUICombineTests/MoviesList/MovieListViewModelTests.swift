//
//  MovieListViewModelTests.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 28/11/2024.
//

import XCTest
import Combine
@testable import SwiftUICombine

class MovieListViewModelTests: XCTestCase {

    var viewModel: MovieListViewModel!
    var mockUseCase: MockMoviesUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        cancellables = []
        mockUseCase = MockMoviesUseCase()
        viewModel = MovieListViewModel(useCase: mockUseCase)
    }

    override func tearDown() {
        cancellables = []
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }

    // Test for loading genres
    func testGetGenreList_Success() {
        let expectation = self.expectation(description: "Genres loaded")
        var hasFulfilled = false  // Flag to prevent multiple fulfill calls
        
        mockUseCase.shouldReturnError = false
        
        viewModel.getGenreList()
        
        viewModel.$genreFilterList
            .dropFirst() // Skip the initial nil value
            .sink { genres in
                if !hasFulfilled {  // Ensure we only call fulfill once
                    XCTAssertEqual(genres.count, 2)
                    XCTAssertEqual(genres.first?.title, "Action")
                    expectation.fulfill()
                    hasFulfilled = true  // Mark as fulfilled
                }
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1)
    }

    
    func testGetMovieList_Success() {
        let expectation = self.expectation(description: "Movies loaded")
        var hasFulfilled = false  // Flag to ensure we only fulfill once

        mockUseCase.shouldReturnError = false
        
        viewModel.getMovieList(with: 1, and: 1)
        
        viewModel.$movieList
            .dropFirst() // Skip the initial nil or empty value
            .sink { movies in
                if !hasFulfilled {
                    XCTAssertEqual(movies.count, 2)
                    XCTAssertEqual(movies.first?.title, "Movie 1")
                    expectation.fulfill()
                    hasFulfilled = true
                }
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1)
    }


    func testGetGenreList_Error() {
        let expectation = self.expectation(description: "Error while loading genres")
        
        mockUseCase.shouldReturnError = true
        
        viewModel.getGenreList()
        
        viewModel.$state
            .dropFirst()
            .sink { state in
                if case .failed = state {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1)
    }
    
    func testGetMovieList_Error() {
        let expectation = self.expectation(description: "Error while loading movies")
        
        mockUseCase.shouldReturnError = true
        
        viewModel.getMovieList(with: 1, and: 1)
        
        viewModel.$state
            .dropFirst()
            .sink { state in
                if case .failed = state {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1)
    }
}
