//
//  DomainError.swift
//  domain
//
//  Created by Jastin on 2/4/22.
//

import Foundation

public enum DomainError: Error {
    case PageNotFound
    case NotValid
}

extension DomainError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .PageNotFound:
            return NSLocalizedString("Page not Found", comment: "Page not found")
        case .NotValid:
            return NSLocalizedString("Invalid", comment: "Invalid")
        }
    }
}
