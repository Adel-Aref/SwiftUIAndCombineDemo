//
//  FilterTabView.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import SwiftUI

struct FilterTabView: View {
    var category: CategoryModel
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        VStack {
            Text(category.title)
                .fontWeight(.bold)
                .font(.system(size: 14))
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(category.isSelected ? Color.yellow : Color.clear)
                .foregroundColor(category.isSelected ? .black : .white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(category.isSelected ? Color.yellow : Color.yellow, lineWidth: 2)
                )
                .cornerRadius(20)
                .onTapGesture {
                    action()
                }
        }
        .frame(maxWidth: .infinity)
        .animation(.easeInOut, value: isSelected)
    }
}

struct CategoryModel: Identifiable, Equatable {
    let id: Int
    let title: String
    var isSelected: Bool
}
