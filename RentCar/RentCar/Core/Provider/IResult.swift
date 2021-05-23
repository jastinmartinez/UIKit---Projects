//
//  IResponse.swift
//  RentCar
//
//  Created by Jastin on 23/5/21.
//

import Foundation

struct IResult<T> {
    let result: T?
    let error: HTTPStatusCode?
    
}
