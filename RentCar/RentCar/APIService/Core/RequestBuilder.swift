//
//  IRequestBuilder.swift
//  RentCar
//
//  Created by Jastin on 30/5/21.
//

import Foundation
import Alamofire

struct RequestBuilder<T> where T: Encodable {
    
    func prepare(url: String, header: HTTPHeader? = nil,model: T,method: HTTPMethod,requiredBearerToken: Bool = false) -> URLRequest {
        var defaultHeader = HTTPHeaders([.contentType("application/json")])
        if requiredBearerToken {
            if let user = DbHelper().getUser{
                defaultHeader.add(HTTPHeader(name: "Authorization", value: "Bearer \(user.token)"))
            }
        }
        if let adtionalHeader = header {
            defaultHeader.add(adtionalHeader)
        }
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.headers = defaultHeader
        urlRequest.method = method
        urlRequest.httpBody = try? JSONEncoder().encode(model)
        return urlRequest
    }
    
    func prepare(url: String, header: HTTPHeader? = nil,requiredBearerToken: Bool = false) -> URLRequest {
        var defaultHeader = HTTPHeaders([.contentType("application/json")])
        if requiredBearerToken {
            if let user = DbHelper().getUser{
                defaultHeader.add(HTTPHeader(name: "Authorization", value: "Bearer \(user.token)"))
            }
        }
        if let adtionalHeader = header {
            defaultHeader.add(adtionalHeader)
        }
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.headers = defaultHeader
        urlRequest.method = .get
        return urlRequest
    }
}
