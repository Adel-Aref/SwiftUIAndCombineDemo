//
//  ShareSheetView.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 01/12/2024.
//

import SwiftUI

struct ShareSheet: View {
    var activityItems: [Any]

    var body: some View {
        ShareSheetController(activityItems: activityItems)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ShareSheetController: UIViewControllerRepresentable {
    var activityItems: [Any]

    func makeUIViewController(context: Context) -> UIActivityViewController {
        return UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
