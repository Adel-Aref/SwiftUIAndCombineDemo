//
//  SearchBarView.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import SwiftUI

struct SearchBarView: View {
    let placeholder: String
    @State private var searchText: String = ""

    var body: some View {
        HStack {
            TextField(placeholder, text: $searchText)
                .padding(10)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .foregroundColor(.white)

            Button(action: {
                searchText = ""
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
}
