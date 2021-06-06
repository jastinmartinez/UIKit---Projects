//
//  File.swift
//  
//
//  Created by Jastin on 20/5/21.
//

import Foundation
import Vapor

protocol IController {
    associatedtype aType
    func create(req: Request) throws -> EventLoopFuture<aType>
    func update(req: Request) throws -> EventLoopFuture<HTTPStatus>
    func remove(req: Request) throws -> EventLoopFuture<HTTPStatus>
    func getModelsOfMark(req: Request) throws -> EventLoopFuture<[aType]>
}
