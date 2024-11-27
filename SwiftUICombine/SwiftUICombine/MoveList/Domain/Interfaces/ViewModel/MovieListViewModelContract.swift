//
//  ViewModel.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import Foundation
import Combine

typealias MovieListViewModelContract = ObservableObject  & MovieListViewModelInput & MovieListViewModelOutput

protocol MovieListViewModelInput {
    var movieList: [Movie] { get set }
    var genreList: [GenreVM] { get set }
    func getMovieList()
    func getGenreList()
}

protocol MovieListViewModelOutput {
    var movieID : String { get }
}
