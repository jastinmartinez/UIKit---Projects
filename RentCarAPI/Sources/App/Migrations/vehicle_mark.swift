//
//  File.swift
//  
//
//  Created by Jastin on 16/5/21.
//

import Foundation
import Fluent

extension VehicleMark {
    struct Migration: Fluent.Migration {
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("vehicle_mark")
                .id()
                .field("vehicle_mark_description",.string,.required)
                .field("vehicle_mark_state",.bool,.required)
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("vehicle_mark").delete()
        }
    }
}

