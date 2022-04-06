//
//  DomainError.swift
//  domain
//
//  Created by Jastin on 2/4/22.
//

import Foundation

public enum DomainError: Error {
    case NotValid
}

extension DomainError : LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .NotValid:
            return NSLocalizedString("Not Content Available", comment: "Invalid")
        }
    }
}
