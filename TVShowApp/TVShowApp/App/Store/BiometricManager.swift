//
//  BiometricManager.swift
//  TVShowApp
//
//  Created by Jastin on 25/11/23.
//

import Foundation
import LocalAuthentication

final public class BiometricManager {
    private let context: LAContext
    private let localStorer: LocalStorer
    
    public init(context: LAContext = .init(),
                localStorer: LocalStorer) {
        self.context = context
        self.localStorer = localStorer
    }
    
    public var isAuthRequired: Bool {
        return localStorer.get(for: .biometric)
    }
    
    public func verify(whenSuccess: ((Bool) -> Void)?,
                       whenFailure: (() -> Void)?) {
        Biometric.context(context).verify { verification in
            switch verification {
            case .success(let state):
                whenSuccess?(state)
            case .failure:
                whenFailure?()
            }
        }
    }
}
