//
//  Untitled.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 27/11/2024.
//


import Combine

open class DisposeObject {
    public var deinitCalled: (() -> Void)?
    public var cancellables: Set<AnyCancellable>

    public init() {
        self.cancellables = Set<AnyCancellable>()
    }

    deinit {
        self.cancellables.removeAll()
        deinitCalled?()
    }
}
