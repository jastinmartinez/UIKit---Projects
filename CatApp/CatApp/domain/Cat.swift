//
//  Cat.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import Foundation

public struct Cat {
    public let id: String
    public let size: Int
    public let tags: [String]?
    public var image: Data?
    
    public init(id: String, size: Int, tags: [String]?, image: Data? = nil) {
        self.id = id
        self.size = size
        self.tags = tags
        self.image = image
    }
    
    public func copy(with data: Data) -> Self {
        return Cat(id: id,
                   size: size,
                   tags: tags,
                   image: data)
    }
}
