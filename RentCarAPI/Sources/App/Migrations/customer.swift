//
//  File.swift
//  
//
//  Created by Jastin on 6/6/21.
//

import Foundation
import Vapor
import Fluent

extension Customer {
    
    struct Migration: Fluent.Migration {
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("customer")
                .id()
                .field("customer_id",.string,.required)
                .field("customer_name",.string,.required)
                .field("customer_credit_card",.string,.required)
                .field("customer_credit_limit",.double,.required)
                .field("customer_person_type",.string,.required)
                .field("customer_state",.bool,.required)
                .unique(on: "customer_id")
                .unique(on: "customer_credit_card")
                .create()
        }
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("customer").delete()
        }
    }
}
