//
//  MovieGridView.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 28/11/2024.
//
import SwiftUI

struct MovieGridView: View {
    let movies: [MovieVM]
    @StateObject var viewModel: MovieListViewModel

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(movies) { movie in
                MovieCardView(movie: movie)
                    .frame(height: 300)
                    .onAppear {
                        // Load more movies when the last item appears
                        if movie.id == movies.last?.id {
                            viewModel.loadNextPage()
                        }
                    }
            }
        }
        .padding(.top, 16)
    }
}
