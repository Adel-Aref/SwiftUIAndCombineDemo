//
//  AppCoordinator.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 01/12/2024.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var rootView: AnyView

    init() {
        self.rootView = AnyView(MovieListView())
    }

    func showMovieList() {
        self.rootView = AnyView(MovieListView())
    }
}
