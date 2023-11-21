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
    
    public func save(for key: String, with value: Bool) {
        localStore.save(for: key, with: value)
    }
    
    public func get(for key: String) -> Result<Bool, Error> {
        return localStore.get(for: key)
    }
}
