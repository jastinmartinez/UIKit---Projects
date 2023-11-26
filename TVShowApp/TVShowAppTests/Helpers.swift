//
//  Helpers.swift
//  TVShowAppTests
//
//  Created by Jastin on 25/11/23.
//

import Foundation
import LocalAuthentication
import TVShowApp
import UIKit
import XCTest

final class LAContextStub: LAContext {
    private(set) var policy: LAPolicy
    private(set) var reason: String
    private(set) var result: Result<Bool, Error>
    
    init(policy: LAPolicy = .deviceOwnerAuthentication,
         reason: String = "",
         result:Result<Bool, Error>) {
        self.policy = policy
        self.reason = reason
        self.result = result
    }
    
    override func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void) {
        self.policy = policy
        self.reason = localizedReason
        
        switch result {
        case .success(let success):
            reply(success, nil)
        case .failure(let failure):
            reply(false, failure)
        }
    }
    
    override func canEvaluatePolicy(_ policy: LAPolicy, error: NSErrorPointer) -> Bool {
        return policy == .deviceOwnerAuthentication
    }
}


final class MockStore: LocalStore {
    
    private var dic = [String: Bool]()
    
    convenience init(key: LocalStorer.Keys, state: Bool) {
        self.init()
        self.save(for: key.rawValue, with: state)
    }
    
    func get(for key: String) -> Bool {
        if let value = dic[key] {
            return value
        } else {
            return false
        }
    }
    
    func save(for key: String, with value: Bool) {
        dic[key] = value
    }
    
    func count() -> Int {
        return dic.count
    }
}
