//
//  BaseViewModel.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 28/11/2024.
//

import Foundation
import UIKit

open class BaseViewModel: DisposeObject {
    // MARK: - PROPERTIES
    @Published public var state: ViewModelState<BaseError> = .idle
}
