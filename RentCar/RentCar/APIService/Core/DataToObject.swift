//
//  ObjectDecodable.swift
//  RentCar
//
//  Created by Jastin on 31/5/21.
//

import Foundation

struct DataToObject<T> where T: Codable {
    
   static func decode(single data: Data) -> T?  {
        
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
   static  func decode(array data: Data) -> [T]?  {
        
        return try? JSONDecoder().decode([T].self, from: data)
    }
}
