//
//  ShowEpisodeEntity.swift
//  DomainLayer
//
//  Created by Jastin on 5/4/22.
//

import Foundation

public struct ShowEpisodeEntity : Decodable {
    public let name: String
    public let number: Int
    public let season: Int
    public let summary: String?
    public let average: ShowEpisodeRatingEntity
    public var image: ShowEpisodeImageEntity
}

public struct ShowEpisodeRatingEntity : Decodable {
    public let average: Double?
    
    public init(average: Double?) {
        self.average = average
    }
}

public struct ShowEpisodeImageEntity : Decodable {
    public let original: String?
    public var imageData: Data? = nil
    
    public init(original: String?) {
        self.original = original
    }
}

