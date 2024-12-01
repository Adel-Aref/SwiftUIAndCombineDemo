//
//  MovieGridView.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 28/11/2024.
//
import SwiftUI

struct MovieGridView: View {
    @StateObject var viewModel: MovieListViewModel

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(viewModel.filteredMovies) { movie in
                NavigationLink(destination: MovieDetailsView(id: movie.id)) {
                    MovieCardView(movie: movie)
                        .frame(height: 300)
                        .onAppear {
                            // Load more movies when the last item appears
                            if movie.id == viewModel.filteredMovies.last?.id {
                                viewModel.loadNextPage()
                            }
                        }
                }
                .buttonStyle(PlainButtonStyle())
                
            }
        }
        .padding(.top, 16)
    }
}
//
