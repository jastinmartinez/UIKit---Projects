//
//  IGetResource.swift
//  RentCar
//
//  Created by Jastin on 18/5/21.
//

import Foundation

 struct IGetResource<T> {
    let url: URL
    let JsonToObject: (Data) -> T?
}
