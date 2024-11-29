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
        
        mockUseCase.shouldReturnError = false
        
        viewModel.getGenreList()
        
        viewModel.$genreFilterList
            .dropFirst()
            .sink { genres in
                XCTAssertEqual(genres.count, 2)
                XCTAssertEqual(genres.first?.title, "Action")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1)
    }
    
    func testGetMovieList_Success() {
        let expectation = self.expectation(description: "Movies loaded")
        
        mockUseCase.shouldReturnError = false
        
        viewModel.getMovieList(with: 1, and: 1)
        
        viewModel.$movieList
            .dropFirst()
            .sink { movies in
                XCTAssertEqual(movies.count, 2)
                XCTAssertEqual(movies.first?.title, "Movie 1")
                expectation.fulfill()
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 1)
    }
    
    func testLoadNextPage() {
        let expectation = self.expectation(description: "Next page loaded")
        
        mockUseCase.shouldReturnError = false
        
        viewModel.getMovieList(with: 1, and: 1)
        
        viewModel.$movieList
            .dropFirst(2)
            .sink { movies in
                XCTAssertEqual(movies.count, 4)
                XCTAssertEqual(self.viewModel.currentPage, 2)
                expectation.fulfill()
            }
            .store(in: &cancellables)
            viewModel.loadNextPage()
        
        waitForExpectations(timeout: 1)
    }
    
    func testFilterMovies() {
        let expectation = self.expectation(description: "Movies filtered")
        
        mockUseCase.shouldReturnError = false
        
        viewModel.getMovieList(with: 1, and: 1)
        
        viewModel.searchText = "Movie 1"
        
        viewModel.$filteredMovies
            .dropFirst()
            .sink { filteredMovies in
                XCTAssertEqual(filteredMovies.count, 1)
                XCTAssertEqual(filteredMovies.first?.title, "Movie 1")
                expectation.fulfill()
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
