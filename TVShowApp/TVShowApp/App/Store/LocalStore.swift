//
//  LocalStore.swift
//  TVShowApp
//
//  Created by Jastin on 20/11/23.
//

import Foundation


public protocol LocalStore {
    func get(for key: String) -> Bool
    func save(for key: String, with value: Bool)
    func count() -> Int
}

