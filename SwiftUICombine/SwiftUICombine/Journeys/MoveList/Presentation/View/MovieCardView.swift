//
//  MovieCardView.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 28/11/2024.
//
import SwiftUI

struct MovieCardView: View {
    let movie: MovieVM
    
    var body: some View {
        VStack(alignment: .leading) {
            // Use AsyncImage to load image from URL
            AsyncImage(url: movie.fullPosterUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 150, height: 225)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 225)
                        .cornerRadius(8)
                        .clipped()
                case .failure:
                    // Placeholder image on failure
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 225)
                        .cornerRadius(8)
                        .clipped()
                @unknown default:
                    EmptyView()
                }
            }
            .padding(.bottom, 8)  // Padding below the image
            
            Text(movie.title ?? "No Title Available")
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(1)
            
            Text(movie.releaseDate ?? "No Release Date")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .background(Color.black.opacity(0.6)) 
        .cornerRadius(12)
        .padding(8)
    }
}

