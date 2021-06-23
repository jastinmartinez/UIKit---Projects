//
//  File.swift
//  
//
//  Created by Jastin on 22/6/21.
//

import Foundation
import Fluent

extension Rent {
    struct Migration: Fluent.Migration {
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("rent")
                .id()
                .field("employee_id",.uuid,.required,.references("employee", .id))
                .field("customer_id",.uuid,.required,.references("customer", .id))
                .field("vehicle_id",.uuid,.required,.references("vehicle", .id))
                .field("rent_date",.string,.required)
                .field("rent_amount_per_day",.double,.required)
                .field("rent_amount_of_day",.int,.required)
                .field("rent_comment",.string)
                .field("rent_state",.bool,.required)
                .create()
        }
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("rent").delete()
        }
    }
}


