//
//  IPostResource.swift
//  RentCar
//
//  Created by Jastin on 21/5/21.
//

import Foundation

struct IPostResource<T : Encodable> {
    var urlRequest: URLRequest
    let model: T
}
