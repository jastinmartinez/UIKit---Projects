//
//  UserDefault+LocalStore.swift
//  TVShowApp
//
//  Created by Jastin on 20/11/23.
//

import Foundation

extension UserDefaults: LocalStore {
    public func get(for key: String) -> Bool {
        return bool(forKey: key)
    }
    
    public func save(for key: String, with value: Bool) {
        setValue(value, forKey: key)
    }
    
    public func count() -> Int {
        return dictionaryRepresentation().keys.count
    }
}
