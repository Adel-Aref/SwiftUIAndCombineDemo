//
//  SwiftUICombineApp.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//

import SwiftUI

@main
struct SwiftUICombineApp: App {
    @StateObject private var coordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            coordinator.rootView
                            .environmentObject(coordinator)
        }
    }
}
