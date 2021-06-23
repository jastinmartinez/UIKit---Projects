//
//  File.swift
//  
//
//  Created by Jastin on 22/6/21.
//

import Foundation
import Fluent

extension Devolution {
    struct Migration: Fluent.Migration  {
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("devolution")
                .id()
                .field("rent_id",.uuid,.required,.references("rent_id", .id))
                .field("employee_id",.uuid,.required,.references("employee_id", .id))
                .field("customer_id",.uuid,.required,.references("customer_id", .id))
                .field("devolution_date",.string,.required)
                .field("devolution_amount_per_day",.double,.required)
                .field("devolution_amount_of_day",.int,.required)
                .field("devolution_comment",.string)
                .field("devolution_state",.string,.required)
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("devolution").delete()
        }
    }
}
