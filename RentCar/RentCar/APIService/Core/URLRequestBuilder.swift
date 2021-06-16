//
//  IRequestBuilder.swift
//  RentCar
//
//  Created by Jastin on 30/5/21.
//

import Foundation
import Alamofire

struct URLRequestBuilder<T> where T: Encodable {
    
    func prepare(url: String, addtionalHeaders: HTTPHeader? = nil,model: T? = nil,method: HTTPMethod = .get,requiredBearerToken: Bool = true) -> URLRequest {
        
        var defaultHeader = HTTPHeaders([.contentType("application/json")])
        
        if requiredBearerToken {
            if let user = UserDefaultsDbHelper().getUser{
                defaultHeader.add(HTTPHeader(name: "Authorization", value: "Bearer \(user.token)"))
            }
        }
        
        if let adtionalHeader = addtionalHeaders {
            defaultHeader.add(adtionalHeader)
        }
        
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.headers = defaultHeader
        urlRequest.method = method
        
        if method != .get && model != nil{
            urlRequest.httpBody = try? JSONEncoder().encode(model)
        }
        
        return urlRequest
    }
}
