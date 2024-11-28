//
//  GenreResponse.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

struct GenreResponse: Codable {    
    var genres: [GenreItem]?
}

struct GenreItem: Codable, Identifiable {
    var id: Int
    var name: String?
}

struct GenreVM: Codable, Identifiable {
    var id: Int
    var title: String?
    var isSelected: Bool = false
    
    init(from response: GenreItem) {
        self.id = response.id
        self.title = response.name
    }
}
