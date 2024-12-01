//
//  MovieDetailsViewModelContract.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import Foundation
import Combine

typealias MovieDetailsViewModelContract = BaseViewModel & ObservableObject  & MovieDetailsViewModelInput & MovieDetailsViewModelOutput

protocol MovieDetailsViewModelInput {
    func getMovieDetails(with id: Int)
}

protocol MovieDetailsViewModelOutput {
    var movieDetailsVM: MovieDetailsVM? { get set }
}
