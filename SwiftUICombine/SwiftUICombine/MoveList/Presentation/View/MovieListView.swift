//
//  ContentView.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import SwiftUI

// Main View
struct MovieListView: View {
    @State private var categories: [CategoryModel] = [
        CategoryModel(title: "Action", isSelected: false),
        CategoryModel(title: "Adventure", isSelected: false),
        CategoryModel(title: "Animation", isSelected: true),
        CategoryModel(title: "Comedy", isSelected: false),
        CategoryModel(title: "Crime", isSelected: false)
    ]

    @State private var selectedCategory: String = "Animation"

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                SearchBarView(placeholder: "Search TMDB")

                Text("Watch New Movies")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                    .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(categories) { category in
                            FilterTabView(category: category) {
                                selectCategory(category)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                MovieGridView(movies: Movie.sampleData)
                    .padding(.horizontal)
                Spacer()
            }
            .background(Color.black.ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }

    private func selectCategory(_ selectedCategory: CategoryModel) {
        // Update the state to set only one category as selected
        for i in categories.indices {
            categories[i].isSelected = (categories[i].id == selectedCategory.id)
        }
        self.selectedCategory = selectedCategory.title
        print("Selected category: \(selectedCategory.title)")
    }
}

struct MovieGridView: View {
    let movies: [Movie]
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(movies) { movie in
                MovieCardView(movie: movie)
            }
        }
    }
}

// Movie Card Component
struct MovieCardView: View {
    let movie: Movie

    var body: some View {
        VStack(alignment: .leading) {
            Image(movie.poster)
                .resizable()
                .scaledToFit()
                .cornerRadius(8)

            Text(movie.title)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(1)

            Text("\(movie.releaseYear)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

// Movie Model
struct Movie: Identifiable {
    let id = UUID()
    let title: String
    let releaseYear: Int
    let poster: String

    static let sampleData = [
        Movie(title: "Ratatouille", releaseYear: 2007, poster: "ratatouille"),
        Movie(title: "Toy Story", releaseYear: 1995, poster: "toystory"),
        Movie(title: "The Boss Baby: Family Business", releaseYear: 2021, poster: "bossbaby"),
        Movie(title: "Tangled", releaseYear: 2010, poster: "tangled")
    ]
}

#Preview {
    MovieListView()
}
