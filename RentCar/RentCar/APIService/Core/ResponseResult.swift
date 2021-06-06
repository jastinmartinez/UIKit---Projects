//
//  IResult.swift
//  RentCar
//
//  Created by Jastin on 30/5/21.
//

import Foundation

struct ResponseResult<T,E> {
   var data: T
   var error: E
}
