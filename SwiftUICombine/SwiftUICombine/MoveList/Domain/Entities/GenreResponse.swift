//
//  GenreResponse.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

struct GenreResponse: Codable, Identifiable {
    var id: Int
    var name: String?
}

struct GenreVM: Codable, Identifiable {
    var id: Int
    var title: String?
    
    init(from response: GenreResponse) {
        self.id = response.id
        self.title = response.name
    }
}
