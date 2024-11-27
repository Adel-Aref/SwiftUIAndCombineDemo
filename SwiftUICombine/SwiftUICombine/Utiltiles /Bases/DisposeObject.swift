//
//  Untitled.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//


import Combine

class DisposeObject {
    var deinitCalled: (() -> Void)?
    var cancellables: Set<AnyCancellable>

    init() {
        self.cancellables = Set<AnyCancellable>()
    }

    deinit {
        self.cancellables.removeAll()
        deinitCalled?()
    }
}
