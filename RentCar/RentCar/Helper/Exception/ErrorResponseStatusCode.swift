//
//  ProviderError.swift
//  RentCar
//
//  Created by Jastin on 23/5/21.
//

import Foundation

enum ErrorResponseStatusCode : Error {
    
    case Unauthorized
}

extension ErrorResponseStatusCode: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .Unauthorized:
            return NSLocalizedString(
                "Direccion de correo o contraseña invalida",
                comment: ""
            )
        }
    }
}


