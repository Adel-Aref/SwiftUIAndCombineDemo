//
//  BaseViewModel.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 28/11/2024.
//

import Foundation
import UIKit

class BaseViewModel: DisposeObject {
    // MARK: - PROPERTIES
    @Published var state: ViewModelState<BaseError> = .idle
}
