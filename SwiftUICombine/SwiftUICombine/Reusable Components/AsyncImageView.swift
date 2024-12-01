//
//  AsyncImageView.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 30/11/2024.
//

import SwiftUI

struct AsyncImageView: View {
    let url: URL?
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    let placeholderImage: String
    let shadowRadius: CGFloat
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: width, height: height)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(cornerRadius)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(cornerRadius)
                    .shadow(radius: shadowRadius)
            case .failure:
                Image(systemName: placeholderImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius)
                    .clipped()
            @unknown default:
                EmptyView()
            }
        }
    }
}

struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageView(
            url: URL(string: "https://www.example.com/image.jpg")!,
            width: 150,
            height: 225,
            cornerRadius: 8,
            placeholderImage: "photo",
            shadowRadius: 10
        )
    }
}
