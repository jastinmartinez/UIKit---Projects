//
//  ShowEntiy.swift
//  domain
//
//  Created by Jastin on 1/4/22.
//

import Foundation

struct ShowEntity  {
    var name: String
    var image: ShowImageEntity
    var schedule: ShowScheduleEntity
    var genres: [String]
    var summary: String
}

struct ShowImageEntity {
    var original: String
}

struct ShowScheduleEntity {
    var time: String
    var days: [String]
}

