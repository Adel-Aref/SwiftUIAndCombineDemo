//
//  GenreVM.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 30/11/2024.
//

import Foundation


struct GenreVM: Codable, Identifiable {
    var id: Int
    var title: String?
    var isSelected: Bool = false
    
    init(from response: GenreItem) {
        self.id = response.id
        self.title = response.name
    }
}

