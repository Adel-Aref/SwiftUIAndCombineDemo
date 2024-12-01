//
//  MovieDetailsVM.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 30/11/2024.
//

import Foundation

struct MovieDetailsVM {
    let title: String
    let image: String
    let releaseDate: String
    let genres: [String]
    let overview: String
    let homepage: String?
    let budget: Int
    let revenue: Int
    let spokenLanguages: [String]
    let status: String
    let releaseYear: String
    let runtime: String
    private var baseUrl = "https://image.tmdb.org/t/p/w500/"

    init(from response: MovieDetailsResponse) {
        self.title = response.title
        self.image = baseUrl + (response.posterPath ?? .empty)
        self.genres = response.genres.map { $0.name }
        self.overview = response.overview
        self.homepage = response.homepage
        self.budget = response.budget ?? 0
        self.revenue = response.revenue ?? 0
        self.status = response.status
        self.spokenLanguages = response.spokenLanguages.map { $0.name }

        if let releaseDate = DateFormatter.movieDateFormatter.date(from: response.releaseDate) {
            let monthYearFormatter = DateFormatter()
            monthYearFormatter.dateFormat = "MMMM yyyy"
            self.releaseDate = monthYearFormatter.string(from: releaseDate)
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "yyyy"
            self.releaseYear = yearFormatter.string(from: releaseDate)
        } else {
            self.releaseYear = ""
            self.releaseDate = ""
        }
        let hours = (response.runtime ?? 0) / 60
        let minutes = (response.runtime ?? 0) % 60
        self.runtime = "\(hours)h \(minutes)m"
    }
    
    var fullPosterUrl: URL? {
        return URL(string: image)
    }
}

extension DateFormatter {
    static let movieDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

