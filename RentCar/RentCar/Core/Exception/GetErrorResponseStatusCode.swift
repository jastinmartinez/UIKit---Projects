//
//  HttpGetStatusCode.swift
//  RentCar
//
//  Created by Jastin on 23/5/21.
//

import Foundation

enum GetErrorResponseStatusCode {
    
    case StatusCode(Int)
}

extension GetErrorResponseStatusCode {
    var status: ErrorResponseStatusCode? {
        switch self {
        case .StatusCode(let code):
            if code == 401 {
                return .Unauthorized
            }
        }
        return nil
    }
}
