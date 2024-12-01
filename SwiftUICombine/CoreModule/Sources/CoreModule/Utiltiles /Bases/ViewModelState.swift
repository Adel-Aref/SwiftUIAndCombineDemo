//
//  ViewModelState.swift
//  SwiftUICombine
//
//  Created by Adel Aref on 28/11/2024.
//


import Foundation

public enum ViewModelState<Error> {
    case idle
    case loading(message: String? = nil)
    case successful
    case failed(Error)
}

// MARK: - ViewModelState+LoaderData
//
extension ViewModelState {
    /// Get message in case of loading state and has message
    ///
    var message: String? {
        guard case .loading(let message) = self else { return nil }
        return message
    }
    
    /// Get message in case of failed state and has error message
    ///
    var errorMessage: String? {
        guard case .failed(let error) = self else { return nil }
        return (error as? BaseError)?.message
    }
}

extension ViewModelState: Equatable {
    public static func == (lhs: ViewModelState<Error>, rhs: ViewModelState<Error>) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle): return true
        case (.loading, .loading): return true
        case (.successful, .successful): return true

        case let (.failed(lhsError), .failed(rhsError)):
            guard let lhsError = lhsError as? BaseError, let rhsError = rhsError as? BaseError else {
                return false
            }
            return lhsError == rhsError

        default:
            return false
        }
    }
}

extension ViewModelState {
    var validationState: ValidationState {
        switch self {
        case .successful:
            return .success

        case .failed(let error):
            return .error(message: ((error as? BaseError)?.message ?? "error1"))

        default: return .none
        }
    }
}

public struct BaseError: Error, Codable {
    let title: String? = ""
    let message: String?
    
    public init(
        message: String? = nil
    ) {
        self.message = message
    }
}

extension BaseError: Equatable {}

public enum ValidationState: Equatable {
    case none
    case success
    case error(message: String)
}

// MARK: - Check Validation State
public extension ValidationState {
    var isValidationFailed: Bool {
        switch self {
        case .error: return true
        default: return false
        }
    }
}
