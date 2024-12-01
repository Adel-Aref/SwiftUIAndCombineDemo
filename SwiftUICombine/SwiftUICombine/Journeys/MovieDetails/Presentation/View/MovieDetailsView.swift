//
//  MovieDetailsView.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 30/11/2024.
//

import SwiftUI
struct MovieDetailsView: View {
    var id: Int
    @StateObject var viewModel = MovieDetailsViewModel()
    @State private var isShareSheetPresented = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImageView(
                    url: viewModel.movieDetailsVM?.fullPosterUrl,
                    width: UIScreen.main.bounds.width,
                    height: 300,
                    cornerRadius: 2,
                    placeholderImage: "photo",
                    shadowRadius: 2
                )
                .padding(.bottom, 8)
                .overlay(
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.left.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 16)
                        .padding(.top, 24)
                        
                        Spacer()
                        
                        Button(action: {
                            isShareSheetPresented.toggle()
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                        .padding(.trailing, 16)
                    }
                        .padding(.top, -150)
                    
                )
                
                HStack {
                    HStack(alignment: .top, spacing: 16) {
                        AsyncImageView(
                            url: viewModel.movieDetailsVM?.fullPosterUrl,
                            width: 100,
                            height: 150,
                            cornerRadius: 8,
                            placeholderImage: "photo",
                            shadowRadius: 4
                        )
                        .padding(.bottom, 4)
                        
                        VStack(alignment: .leading) {
                            Text(viewModel.titleAndYear)
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding(.top, 4)
                            Text(viewModel.movieDetailsVM?.genres.map { $0 }.joined(separator: ", ") ?? .empty)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        
                        
                    }
                    
                }
                .padding(.horizontal)
                
                Text(viewModel.movieDetailsVM?.overview ?? "No Overview Available")
                    .font(.body)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                
                if let homepage = viewModel.movieDetailsVM?.homepage, let url = URL(string: homepage) {
                    Link("Homepage \(homepage)", destination: url)
                        .font(.body)
                        .foregroundColor(.blue)
                        .padding(.horizontal)
                }
                
                if let spokenLanguages = viewModel.movieDetailsVM?.spokenLanguages {
                    Text("Languages: \(spokenLanguages.map { $0 }.joined(separator: ", "))")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
                
                HStack {
                    Text("Status: \(viewModel.movieDetailsVM?.status ?? "N/A")")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    if let runtime = viewModel.movieDetailsVM?.runtime {
                        Text("Runtime: \(runtime) minutes")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal)
                
                if let budget = viewModel.movieDetailsVM?.budget, let revenue = viewModel.movieDetailsVM?.revenue {
                    HStack {
                        Text("Budget: \(budget.formattedCurrency())")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        Spacer()
                        Text("Revenue: \(revenue.formattedCurrency())")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding(.top)
            .onAppear {
                viewModel.getMovieDetails(with: id)
            }
        }
        .background(Color.black.ignoresSafeArea())
        .navigationBarHidden(true)
        .sheet(isPresented: $isShareSheetPresented) {
            ShareSheet(activityItems: [viewModel.movieDetailsVM?.title ?? "No Title", viewModel.movieDetailsVM?.homepage ?? ""])
        }
    }
}
