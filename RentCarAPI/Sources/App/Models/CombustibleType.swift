//
//  File.swift
//  
//
//  Created by Jastin on 20/5/21.
//

import Vapor
import Fluent

final class CombustibleType: ContenModel {
    
    static var schema: String = "combustible_type"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "combustible_type_description")
    var description: String
    
    @Field(key: "combustible_type_state")
    var state: Bool
    
    init() {}
    
    init(id: UUID? = nil, description: String,state: Bool)  {
        self.id = id
        self.description = description
        self.state = state
    }
}
