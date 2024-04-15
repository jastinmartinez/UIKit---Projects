//
//  CatLoader.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import Foundation

public protocol CatLoader {
    typealias Result = Swift.Result<[Cat], Error>
    func load(completion: @escaping (Result) -> Void)
}
