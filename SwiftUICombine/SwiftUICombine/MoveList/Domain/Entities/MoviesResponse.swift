//
//  MoviesResponse.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 28/11/2024.
//
import Foundation

struct MoviesResponse: Codable {
    var page: Int?
    var totalPages: Int?
    var results: [MovieItem]?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}

struct MovieItem: Codable, Identifiable {
    var id: Int
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var posterPath: String?
    var releaseDate: String?
    var title: String?
    var voteAverage: Double?
    var genreIds: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case id, overview, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case voteAverage = "vote_average"
    }
}

struct MovieVM: Codable, Identifiable {
    var id: Int
    var title: String?
    var releaseDate: String?
    var posterPath: String?
    
    private let baseUrl = "https://image.tmdb.org/t/p/w500/"
    
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

//self.posterPath = "https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg"
