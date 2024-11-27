//
//  FilterTabView.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import SwiftUI

struct FilterTabView: View {
    let category: CategoryModel
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Text(category.title)
                .fontWeight(.bold)
                .font(.system(size: 14))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(category.isSelected ? Color.yellow : Color.clear)
                .foregroundColor(category.isSelected ? .black : .white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(category.isSelected ? Color.yellow : Color.yellow, lineWidth: 1)
                )
                .cornerRadius(20)
        }
    }
}

struct CategoryModel: Identifiable {
    let id = UUID()
    let title: String
    var isSelected: Bool
}
