//
//  File.swift
//  
//
//  Created by Jastin on 16/5/21.
//

import Foundation
import Fluent

extension VehicleModel {
    struct Migration: Fluent.Migration {
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("vehicle_model")
                .id()
                .field("vehicle_model_description",.string,.required)
                .field("vehicle_mark_id",.uuid,.required,.references("vehicle_mark", "id"))
                .field("vehicle_model_state",.bool,.required)
                .create()
        }
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("vehicle_model").delete()
        }
    }
}



