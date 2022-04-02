//
//  Show.swift
//  data
//
//  Created by Jastin on 1/4/22.
//

import Foundation
import domain

public struct ShowModel : Decodable {
    let name: String
    let image: ShowImageModel
    let schedule: ShowScheduleModel
    let genres: [String]
    let summary: String
    
    func toShowEntity() -> ShowEntity {
        return ShowEntity(name: self.name, image: self.image.toShowImageEntity(), schedule: self.schedule.toShowScheduleEntity(), genres: self.genres, summary: self.summary)
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

