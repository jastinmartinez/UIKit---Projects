//
//  Show.swift
//  data
//
//  Created by Jastin on 1/4/22.
//

import Foundation
import DomainLayer

public struct ShowModel : Decodable {
    let id: Int
    let name: String
    let image: ShowImageModel
    let schedule: ShowScheduleModel
    let genres: [String]
    let summary: String
    let rating: ShowRatingModel
    
    func toShowEntity() -> ShowEntity {
        return ShowEntity(id: self.id, name: self.name, image: self.image.toShowImageEntity(), schedule: self.schedule.toShowScheduleEntity(), genres: self.genres, summary: self.summary, rating: rating.toShowRatingEntity())
    }
}

struct ShowImageModel : Decodable {
    let original: String
    
    func toShowImageEntity() -> ShowImageEntity {
        return ShowImageEntity(original: self.original)
    }
}

struct ShowScheduleModel : Decodable {
    let time: String
    let days: [String]
    
    func toShowScheduleEntity() -> ShowScheduleEntity {
        return ShowScheduleEntity(time: self.time, days: self.days)
    }
}

struct ShowRatingModel : Decodable {
    let average: Double?

    func toShowRatingEntity() -> ShowRatingEntity {
        return ShowRatingEntity(average: self.average)
    }
}

