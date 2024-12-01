//
//  MovieDetailsResponse.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 28/11/2024.
//
import Foundation

// MARK: - MovieDetailsResponse
// MARK: - MovieDetailsResponse
struct MovieDetailsResponse: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String
    let genres: [Genre]
    let overview: String
    let homepage: String?
    let budget: Int?
    let revenue: Int?
    let spokenLanguages: [SpokenLanguage]
    let status: String
    let runtime: Int?

    var formattedReleaseDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: releaseDate) {
            formatter.dateFormat = "MMMM yyyy" // Month and year
            return formatter.string(from: date)
        }
        return releaseDate 
    }

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case genres
        case overview
        case homepage
        case budget
        case revenue
        case spokenLanguages = "spoken_languages"
        case status
        case runtime
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName: String
    let iso6391: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name
    }
}
