//
//  MovieListViewModel.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//


import SwiftUI


class MovieListViewModel: MovieListViewModelContract {
   
    @Published var movieList: [Movie] = []
    @Published var isLoading: Bool = false

}
