//
//  File.swift
//  
//
//  Created by Jastin on 16/5/21.
//

import Foundation
import Fluent

struct VehicleType: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        database.schema("vehicle_type")
            .id()
            .field("vehicle_type_description", .string, .required)
            .field("vehicle_type_state", .bool, .required)
            .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("vehicle_type").delete()
    }
}
