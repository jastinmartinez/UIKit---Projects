//
//  IURLRequest.swift
//  RentCar
//
//  Created by Jastin on 22/5/21.
//

import Foundation

final class IURLRequest {
    
    func prepare(method: HttpMethods,url: URL,parameters: (key: String, value: String)?) -> URLRequest
    {
        var urlRequest = URLRequest(url: url)
        if method == .POST {
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            if let tuple = parameters {
            
                urlRequest.addValue(tuple.value, forHTTPHeaderField: tuple.key)
            }
        }
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
