//
//  AFErrorToDomainErrorHelper.swift
//  data
//
//  Created by Jastin on 2/4/22.
//

import Foundation
import Alamofire
import DomainLayer

final class AFErrorToDomainErrorHelper {
    class func errorTypeOf(_ afError: AFError) -> DomainError {
        switch afError.responseCode {
        case 404:
            return .PageNotFound
        default:
            return .NotValid
        }
    }
}
