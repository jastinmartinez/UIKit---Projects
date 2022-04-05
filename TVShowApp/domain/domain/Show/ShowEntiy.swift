//
//  ShowEntiy.swift
//  domain
//
//  Created by Jastin on 1/4/22.
//

import Foundation

public struct ShowEntity  {
    public let id: Int
    public let name: String
    public var image: ShowImageEntity?
    public let schedule: ShowScheduleEntity
    public let genres: [String]
    public let summary: String?
    public let rating: ShowRatingEntity
    
    public init(id: Int,name: String,image: ShowImageEntity?, schedule: ShowScheduleEntity,genres: [String],summary: String?, rating: ShowRatingEntity) {
        self.id = id
        self.name = name
        self.image = image
        self.schedule = schedule
        self.genres = genres
        self.summary = summary
        self.rating = rating
    }
}

public struct ShowImageEntity {
    public let original: String
    public var data: Data?
    
    public init(original: String, data: Data? = nil) {
        self.original = original
        self.data =  data
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

public struct ShowRatingEntity {
    public let average: Double?
    
    public init(average: Double?) {
        self.average = average
    }
}

