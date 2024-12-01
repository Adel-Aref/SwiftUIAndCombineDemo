//
//  MovieListViewModel.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//


import SwiftUI
import CoreModule

class MovieListViewModel: MovieListViewModelContract {
    
    private let useCase: MoviesUseCaseContract
    @Published var genreFilterList: [CategoryModel] = []
    @Published var movieList: [MovieVM] = []
    @Published var filteredMovies: [MovieVM] = []
    @Published var isLoading: Bool = false
    @Published var currentPage: Int = 1
    @Published var searchText: String = "" {
        didSet {
            filterMovies()
        }
    }
    
    private var totalPages: Int = 1
    var selectedGenreID: Int = 1
    // MARK: - INIT
    init(
        useCase: MoviesUseCaseContract = FetchMoviesUseCase()
    ) {
        self.useCase = useCase
        super.init()
        self.getGenreList()
        getMovieList(and: currentPage)
    }
    
    func getGenreList() {
        state = .loading(message: "start loading")
        useCase.executeGenres()
            .compactMap { responseList in
                responseList.genres?.compactMap { GenreVM(from: $0) }
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                guard case let .failure(error) = completion else { return }
                self?.state = .failed(BaseError(message: error.localizedDescription))
            } receiveValue: { [weak self] response in
                self?.genreFilterList = self?.mapGenreToCategoryFilter(genres: response) ?? []
                self?.state = .successful
            }
            .store(in: &cancellables)
    }
    
    func mapGenreToCategoryFilter(genres: [GenreVM]) -> [CategoryModel] {
        genres.compactMap { genre in
            return CategoryModel(id: genre.id, title: genre.title ?? "", isSelected: false)
        }
    }
    
    func selectCategory(_ selectedCategory: CategoryModel) {
        genreFilterList = genreFilterList.map { genre in
            var updatedGenre = genre
            updatedGenre.isSelected = (genre.id == selectedCategory.id)
            selectedGenreID = updatedGenre.id
            return updatedGenre
        }
        getMovieList(with: selectedCategory.id, and: currentPage)
    }
    
    func getMovieList(with genreId: Int? = nil, and page: Int) {
        state = .loading(message: "start loading")
        useCase.executeMovies(with: genreId, and: page)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                guard case let .failure(error) = completion else { return }
                self?.state = .failed(BaseError(message: error.localizedDescription))
            } receiveValue: { [weak self] response in
                if page == 1 {
                    self?.movieList = response.results?.map { MovieVM(from: $0) } ?? []
                    self?.filteredMovies = response.results?.map { MovieVM(from: $0) } ?? []
                } else {
                    self?.movieList.append(contentsOf: response.results?.map { MovieVM(from: $0) } ?? [])
                    self?.filteredMovies.append(contentsOf: response.results?.map { MovieVM(from: $0) } ?? [])
                }
                
                self?.totalPages = response.totalPages ?? 1
                self?.state = .successful
            }
            .store(in: &cancellables)
    }
    
    func loadNextPage() {
        guard currentPage < totalPages else { return }
        currentPage += 1
        getMovieList(with: selectedGenreID, and: currentPage)
    }
    
    func filterMovies() {
        if searchText.isEmpty {
            filteredMovies = movieList
        } else {
            filteredMovies = movieList.filter { movie in
                movie.title?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
    }
}
