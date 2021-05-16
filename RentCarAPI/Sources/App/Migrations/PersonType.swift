//
//  File.swift
//  
//
//  Created by Jastin on 16/5/21.
//

import Foundation
import  Fluent

struct PersonType: Migration  {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("person_type")
            .id()
            .field("person_type_description",.string,.required)
            .field("person_type_state",.bool,.required)
            .create()
    }
}
