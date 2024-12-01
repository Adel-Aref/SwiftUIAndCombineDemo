//
//  MovieVM.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 30/11/2024.
//

import Foundation

struct MovieVM: Codable, Identifiable {
    var id: Int
    var title: String?
    var releaseDate: String?
    var posterPath: String?
    
    private var baseUrl = "https://image.tmdb.org/t/p/w500/"
    
    init(from response: MovieItem) {
        self.id = response.id
        self.title = response.title
        self.releaseDate = response.releaseDate
        self.posterPath = response.posterPath.flatMap { baseUrl + $0 }
    }
    
    var fullPosterUrl: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: posterPath)
    }
}
