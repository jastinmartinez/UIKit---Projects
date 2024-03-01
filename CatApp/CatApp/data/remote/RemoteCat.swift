//
//  RemoteCat.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import Foundation

public struct RemoteCat: Decodable {
    public let id: String
    public let size: Int
    public let tags: [String]?
    
    public init(id: String, size: Int, tags: [String]?) {
        self.id = id
        self.size = size
        self.tags = tags
    }
}

extension RemoteCat {
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case size
        case tags
    }
}

extension Array where Element == RemoteCat {
     func toModels() -> [Cat] {
        return map({ Cat(id: $0.id,
                         size: $0.size,
                         tags: $0.tags )})
    }
}
