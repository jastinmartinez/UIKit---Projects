//
//  File.swift
//  
//
//  Created by Jastin on 16/5/21.
//

import Foundation
import Fluent

extension UserToken {
    struct Table: Migration {
        
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("user_tokens")
                .id()
                .field("value",.string,.required)
                .field("user_id",.uuid,.required,.references("users", "id"))
                .unique(on: "value")
                .create()
        }
        
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("user_tokens").delete()
        }
    }
}
