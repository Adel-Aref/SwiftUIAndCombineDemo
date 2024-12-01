//
//  MovieDetailsViewModel.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//


import SwiftUI
import CoreModule

class MovieDetailsViewModel: MovieDetailsViewModelContract {
    
    private let useCase: MovieDetailsUseCaseContract

    @Published var movieDetailsVM: MovieDetailsVM?
    @Published var isLoading: Bool = false
    // MARK: - INIT
    init(
        useCase: MovieDetailsUseCaseContract = FetchMovieDetailsUseCase()
    ) {
        self.useCase = useCase
        super.init()
    }
    
    var titleAndYear: String {
        let title = movieDetailsVM?.title ?? .empty
        let year = movieDetailsVM?.releaseYear ?? .empty
        return "\(title) (\(year))"
    }
    
    func getMovieDetails(with id: Int) {
        state = .loading(message: "start loading")
        useCase.executeMovies(with: id)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                guard case let .failure(error) = completion else { return }
                self?.state = .failed(BaseError(message: error.localizedDescription))
            } receiveValue: { [weak self] response in
                self?.movieDetailsVM = MovieDetailsVM(from: response)
                self?.state = .successful
            }
            .store(in: &cancellables)
    }
}
