//
//  HttpGetStatusCode.swift
//  RentCar
//
//  Created by Jastin on 23/5/21.
//

import Foundation

enum HttpGetStatusCode {
    
    case StatusCode(Int)
}

extension HttpGetStatusCode {
    var status: HTTPStatusCode? {
        switch self {
        case .StatusCode(let code):
            if code == 401 {
                return .Unauthorized
            }
        }
        return nil
    }
}
