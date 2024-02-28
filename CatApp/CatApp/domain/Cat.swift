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
    
    public init(id: String, size: Int, tags: [String]?) {
        self.id = id
        self.size = size
        self.tags = tags
    }
}
