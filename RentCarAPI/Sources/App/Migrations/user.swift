//
//  File.swift
//  
//
//  Created by Jastin on 16/5/21.
//

import Foundation
import Fluent
import Vapor

extension User {
    struct Migration: Fluent.Migration {
        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("users")
                .id()
                .field("user_name",.string,.required)
                .field("user_email",.string,.required)
                .field("user_password_hash",.string,.required)
                .unique(on: "user_email")
                .create()
        }
        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("users").delete()
        }
    }
}
