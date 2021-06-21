//
//  File.swift
//  
//
//  Created by Jastin on 20/6/21.
//

import Foundation
import Fluent
extension Vehicle {
    struct Migration: Fluent.Migration {
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("vehicle")
                .id()
                .field("vehicle_description",.string,.required)
                .field("vehicle_chasis_number",.string,.required)
                .field("vehicle_engine_number",.string,.required)
                .field("vehicle_plate",.string,.required)
                .field("vehicle_vehicle_type",.uuid,.required,.references("vehicle_type", .id))
                .field("vehicle_vehicle_mark",.uuid,.required,.references("vehicle_mark", .id))
                .field("vehicle_vehicle_model",.uuid,.required,.references("vehicle_model", .id))
                .field("vehicle_combustible_type",.uuid,.required,.references("vehicle_type", .id))
                .field("vehicle_state",.bool,.required)
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("vehicle").delete()
        }
    }
}
