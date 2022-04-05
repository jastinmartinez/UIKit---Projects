//
//  ShowEpisodeModel.swift
//  DataLayer
//
//  Created by Jastin on 5/4/22.
//

import Foundation
import DomainLayer

public struct ShowEpisodeModel : Decodable {
     let id: Int
     let name: String
     let number: Int
     let season: Int
     let summary: String?
     let average: ShowEpisodeRatingModel
     let image: ShowEpisodeImageModel
     
     func toShowEpisodeEntity() -> ShowEpisodeEntity {
         return ShowEpisodeEntity(id: self.id, name: self.name, number: self.number, season: self.season, summary: self.summary, rating: self.average.toShowEpisodeRatingEntity(), image: self.image.toShowEpisodeImageEntity())
     }
}

struct ShowEpisodeRatingModel : Decodable {
    let average: Double?
    
    func toShowEpisodeRatingEntity() -> ShowEpisodeRatingEntity {
        return ShowEpisodeRatingEntity(average: self.average)
    }
}

struct ShowEpisodeImageModel : Decodable {
    let original: String?
    
    func toShowEpisodeImageEntity() -> ShowEpisodeImageEntity {
        return ShowEpisodeImageEntity(original: self.original)
    }
}
