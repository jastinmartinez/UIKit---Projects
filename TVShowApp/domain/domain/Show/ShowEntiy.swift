//
//  ShowEntiy.swift
//  domain
//
//  Created by Jastin on 1/4/22.
//

import Foundation

public struct ShowEntity  {
    let name: String
    let image: ShowImageEntity
    let schedule: ShowScheduleEntity
    let genres: [String]
    let summary: String
    
    public init(name: String,image: ShowImageEntity, schedule: ShowScheduleEntity,genres: [String],summary: String) {
        self.name = name
        self.image = image
        self.schedule = schedule
        self.genres = genres
        self.summary = summary
    }
}

public struct ShowImageEntity {
    let original: String
    
    public init(original: String) {
        self.original = original
    }
}

public struct ShowScheduleEntity {
    let time: String
    let days: [String]
    
    public init(time: String,days: [String]) {
        self.time = time
        self.days = days
    }
}

