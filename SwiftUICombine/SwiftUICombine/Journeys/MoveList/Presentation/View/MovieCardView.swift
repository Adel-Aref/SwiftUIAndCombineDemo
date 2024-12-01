//
//  MovieCardView.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 28/11/2024.
//
import SwiftUI

struct MovieCardView: View {
    let movie: MovieVM
    let numberOfCards: CGFloat = 2
    let padding: CGFloat = 24
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImageView(
                url: movie.fullPosterUrl,
                width: (UIScreen.main.bounds.width - (2 * padding)) / numberOfCards,
                height: 240,
                cornerRadius: 8,
                placeholderImage: "photo",
                shadowRadius: 8
            )
            .padding(.bottom, 8)
            
            Text(movie.title ?? .empty)
                .font(.headline)
                .foregroundColor(.white)
                .lineLimit(1)
            
            Text(movie.releaseYear)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .background(Color.black.opacity(0.6)) 
        .cornerRadius(12)
        .padding(8)
    }
}

