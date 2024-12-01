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
    let releaseYear: String

    private var baseUrl = "https://image.tmdb.org/t/p/w500/"
    
    init(from response: MovieItem) {
        self.id = response.id
        self.title = response.title
        self.releaseDate = response.releaseDate
        if let releaseDate = DateFormatter.movieDateFormatter.date(from: response.releaseDate ?? .empty) {
            let monthYearFormatter = DateFormatter()
            monthYearFormatter.dateFormat = "MMMM yyyy"
            self.releaseDate = monthYearFormatter.string(from: releaseDate)
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "yyyy"
            self.releaseYear = yearFormatter.string(from: releaseDate)
        } else {
            self.releaseYear = ""
        }
        self.posterPath = response.posterPath.flatMap { baseUrl + $0 }
    }
    
    var fullPosterUrl: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: posterPath)
    }
}
