//
//  File.swift
//  
//
//  Created by Jastin on 16/5/21.
//

import Foundation
import Fluent

struct JobShift: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("job_shift")
            .id()
            .field("job_shift_description",.string,.required)
            .field("job_shift_state",.bool,.required)
            .create()
    }
    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("job_shift").delete()
    }
}
