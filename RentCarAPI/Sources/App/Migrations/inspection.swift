//
//  File.swift
//  
//
//  Created by Jastin on 22/6/21.
//

import Foundation
import Fluent

extension Inspection {
    
    struct Migration: Fluent.Migration {
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("inspection")
                .id()
                .field("vehicle_id",.uuid,.required,.references("vehicle", .id))
                .field("customer_id",.uuid,.required,.references("customer", .id))
                .field("inspection_scratch",.bool,.required)
                .field("inspection_combustible_amount",.string,.required)
                .field("inpection_rubber_back",.bool,.required)
                .field("inspection_hydraulic_jack",.bool,.required)
                .field("inspection_glass_breakage",.bool,.required)
                .field("inspection_rubber_state_1",.bool,.required)
                .field("inspection_rubber_state_2",.bool,.required)
                .field("inspection_rubber_state_3",.bool,.required)
                .field("inspection_rubber_state_4",.bool,.required)
                .field("inspection_date",.string,.required)
                .field("employee_id",.uuid,.required,.references("employee", .id))
                .field("inspection_state",.bool,.required)
                .create()
        }
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("inspection").delete()
        }
    }
}
