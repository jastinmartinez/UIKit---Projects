//
//  ObjectDecodable.swift
//  RentCar
//
//  Created by Jastin on 31/5/21.
//

import Foundation

final class ObjectCodable {
    
    func decode<T : Codable>(_ data: Data) -> T?  {
        
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    func decode<T : Codable>(_ data: Data) -> [T]?  {
        
        return try? JSONDecoder().decode([T].self, from: data)
    }
}
