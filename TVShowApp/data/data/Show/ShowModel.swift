//
//  Show.swift
//  data
//
//  Created by Jastin on 1/4/22.
//

import Foundation

struct ShowModel : Decodable {
    var name: String
    var image: ShowImageModel
    var schedule: ShowScheduleModel
    var genres: [String]
    var summary: String
}

struct ShowImageModel : Decodable {
    var original: String
}

struct ShowScheduleModel : Decodable {
    var time: String
    var days: [String]
}

