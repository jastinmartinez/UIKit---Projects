//
//  File.swift
//  
//
//  Created by Jastin on 16/5/21.
//

import Foundation
import Fluent
extension User {
    struct Table: Migration {
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("user")
                .id()
                .field("user_name",.string,.required)
                .field("user_email",.string,.required)
                .field("user_password_hash",.string,.required)
                .create()
        }
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("user").delete()
        }
    }
}
