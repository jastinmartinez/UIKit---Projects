//
//  UserToken.swift
//  RentCar
//
//  Created by Jastin on 21/5/21.
//

import Foundation

struct UserToken : Decodable {
    var id: UUID
    var value: String
    var user: UserID
}
struct UserID: Decodable {
    var id: UUID
}
