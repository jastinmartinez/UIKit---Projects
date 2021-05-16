//
//  File.swift
//  
//
//  Created by Jastin on 16/5/21.
//

import Foundation
import Fluent

struct CombustibleType: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("combustible_type")
            .id()
            .field("combustible_type_description", .string, .required)
            .field("combustible_type_state",.bool, .required)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("combustible_type").delete()
    }
}
