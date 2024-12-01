//
//  GenreResponse.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//
import Foundation

struct GenreResponse: Codable {
    var genres: [GenreItem]?
}

struct GenreItem: Codable, Identifiable {
    var id: Int
    var name: String?
}
