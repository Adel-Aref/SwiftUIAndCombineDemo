//
//  ViewModel.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import Foundation
import Combine

typealias MovieListViewModelContract = BaseViewModel & ObservableObject  & MovieListViewModelInput & MovieListViewModelOutput

protocol MovieListViewModelInput {
    func getMovieList(with genreId: Int?, and page: Int)
    func getGenreList()
}

protocol MovieListViewModelOutput {
//    var movieID : String { get }
    var genreFilterList: [CategoryModel] { get set }
    var movieList: [MovieVM] { get set }
}
