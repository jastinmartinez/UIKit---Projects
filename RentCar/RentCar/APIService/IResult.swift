//
//  IResult.swift
//  RentCar
//
//  Created by Jastin on 30/5/21.
//

import Foundation

struct IResult<T,E> {
   var data: T
   var error: E
}
