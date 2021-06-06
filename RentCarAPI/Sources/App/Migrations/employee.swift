//
//  File.swift
//  
//
//  Created by Jastin on 6/6/21.
//

import Foundation
import Vapor
import Fluent

extension Employee {
    
    struct Migration: Fluent.Migration {
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("employee")
                .id()
                .field("employee_id",.string,.required)
                .field("employee_name",.string,.required)
                .field("employee_job_shift",.string,.required)
                .field("employee_commission_percent",.double,.required)
                .field("employee_started_date",.date,.required)
                .field("employee_state",.bool,.required)
                .create()
        }
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("employee").delete()
        }
    }
}

