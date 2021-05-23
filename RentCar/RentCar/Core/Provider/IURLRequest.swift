//
//  IURLRequest.swift
//  RentCar
//
//  Created by Jastin on 22/5/21.
//

import Foundation

final class IURLRequest {
    
    func prepare(method: HttpMethods,url: URL) -> URLRequest
    {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
