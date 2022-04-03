//
//  ShowEntiy.swift
//  domain
//
//  Created by Jastin on 1/4/22.
//

import Foundation

public struct ShowEntity  {
    public let name: String
    public let image: ShowImageEntity
    public let schedule: ShowScheduleEntity
    public let genres: [String]
    public let summary: String
    
    public init(name: String,image: ShowImageEntity, schedule: ShowScheduleEntity,genres: [String],summary: String) {
        self.name = name
        self.image = image
        self.schedule = schedule
        self.genres = genres
        self.summary = summary
    }
}

public struct ShowImageEntity {
    public let original: String
    
    public init(original: String) {
        self.original = original
    }
}

public struct ShowScheduleEntity {
    public let time: String
    public let days: [String]
    
    public init(time: String,days: [String]) {
        self.time = time
        self.days = days
    }
}

