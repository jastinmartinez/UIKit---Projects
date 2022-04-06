//
//  BiometricalAuthentication.swift
//  TVShowApp
//
//  Created by Jastin on 6/4/22.
//

import Foundation
import LocalAuthentication

final class BiometricalAuthentication {
    class func isAuthenticationSuccessful(handler: ((Bool) -> Void)?) {
        let context = LAContext()
        var reason = "Log in with"
        switch context.biometryType {
        case .faceID:
            reason += "FaceID"
        case .none:
           break
        case .touchID:
            reason += "TouchID"
        @unknown default:
            break
        }
        context.evaluatePolicy(
            .deviceOwnerAuthentication,
            localizedReason: reason
        ) { success, _ in
            handler?(success)
        }
    }
}
