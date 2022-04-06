//
//  ShowEpisodeEntity.swift
//  DomainLayer
//
//  Created by Jastin on 5/4/22.
//

import Foundation

public struct ShowEpisodeEntity : Decodable {
    public let id: Int
    public let name: String
    public let number: Int
    public let season: Int
    public let summary: String?
    public let rating: ShowEpisodeRatingEntity
    public var image: ShowEpisodeImageEntity?
    
    public init(id: Int, name: String, number: Int, season: Int, summary: String? ,rating: ShowEpisodeRatingEntity, image: ShowEpisodeImageEntity?) {
        self.id = id
        self.name = name
        self.number = number
        self.season = season
        self.summary = summary
        self.rating = rating
        self.image = image
    }
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

