//
//  ContentView.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import SwiftUI

struct MovieListView: View {
    @StateObject var viewModel = MovieListViewModel()
    @State private var selectedCategory: String = "Animation"

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                SearchBarView(placeholder: "Search TMDB", text: $viewModel.searchText)
                
                Text("Watch New Movies")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.yellow)
                    .padding(.horizontal)
                
                switch viewModel.state {
                case .idle:
                    EmptyView()
                case .loading(let message):
                    VStack {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .yellow))
                        if let message = message {
                            Text(message)
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.6).ignoresSafeArea())
                    .cornerRadius(12)
                case .successful:
                    ScrollViewReader { scrollView in
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(viewModel.genreFilterList) { category in
                                    FilterTabView(category: category, isSelected: category.isSelected) {
                                        viewModel.selectCategory(category)
                                        withAnimation {
                                            scrollView.scrollTo(category.title, anchor: .center)
                                        }
                                    }
                                    .id(category.title)
                                    .padding(.horizontal)
                                }
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    
                    ScrollView(showsIndicators: false,
                               content: {
                        LazyVStack(alignment: .leading, spacing: 12) {
                            MovieGridView(viewModel: viewModel)
                                .padding(.horizontal)
                            Spacer()
                        }
                    })
                case .failed(let error):
                    Text("Failed to load genres: \(error.localizedDescription)")
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                Spacer()
            }
            .background(Color.black.ignoresSafeArea())
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    MovieListView()
}

