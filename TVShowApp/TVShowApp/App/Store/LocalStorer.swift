//
//  LocalStorer.swift
//  TVShowApp
//
//  Created by Jastin on 20/11/23.
//

import Foundation

public final class LocalStorer {
    
    private let localStore: LocalStore
    
    public var count: Int  {
        return localStore.count()
    }
    
    public required init(localStore: LocalStore) {
        self.localStore = localStore
    }
    
    public func save(for key: Keys, with value: Bool) {
        localStore.save(for: key.rawValue, with: value)
    }
    
    public func get(for key: Keys) -> Bool {
        return localStore.get(for: key.rawValue)
    }
}

extension LocalStorer {
    public enum Keys: String {
        case biometric
    }
}
