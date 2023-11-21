//
//  BiometricalAuthentication.swift
//  TVShowApp
//
//  Created by Jastin on 6/4/22.
//

import Foundation
import LocalAuthentication

final class BiometricalAuthentication {
    class func verify(handler: ((Bool) -> Void)?) {
        let context = LAContext()
        let reason = "Log in with" + context.localizedReason
        context.evaluatePolicy(
            .deviceOwnerAuthentication,
            localizedReason: reason
        ) { success, _ in
            handler?(success)
        }
    }
}


public enum Biometric {
    case context(LAContext)
    
    public func verify(completion: @escaping (Result<Bool, Error>) -> Void) {
        switch self {
        case .context(let context):
            if context.canEvaluatePolicy(.deviceOwnerAuthentication,
                                         error: nil) {
                let reason = "Log in with" + context.localizedReason
                evaluate(context, reason, completion)
            } else {
                completion(.success(false))
            }
        }
    }
    
    fileprivate func evaluate(_ context: (LAContext),
                              _ reason: String,
                              _ completion: @escaping (Result<Bool, Error>) -> Void) {
        context.evaluatePolicy(
            .deviceOwnerAuthentication,
            localizedReason: reason
        ) { success, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(success))
        }
    }
}
