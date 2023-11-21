//
//  BiometricalTests.swift
//  TVShowAppTests
//
//  Created by Jastin on 21/11/23.
//

import XCTest
import LocalAuthentication
import TVShowApp

final class BiometricalTests: XCTestCase {
    
    func test_biometric_policy_isDeviceOwnerAuthentication() {
        let contextStub = LAContextStub(result: .success(true))
        
        Biometrical.context(contextStub).verify(completion: {_ in})
        
        XCTAssertEqual(LAPolicy.deviceOwnerAuthentication, contextStub.policy)
    }
    
    func test_biometric_receivedReasonWhyIsRequired() {
        let contextStub = LAContextStub(result: .success(true))
        
        Biometrical.context(contextStub).verify(completion: {_ in})
        
        XCTAssertEqual("Log in with" + contextStub.localizedReason, contextStub.reason)
    }
    
    func test_biometric_deliversSuccessWithTrue() {
        var captured = false
        let contextStub = LAContextStub(result: .success(true))
        
        let exp = expectation(description: "wait for auth")
        Biometrical.context(contextStub).verify(completion: { reply in
            exp.fulfill()
            switch reply {
            case .success(let success):
                XCTAssertEqual(true, success)
            case .failure:
                XCTFail("expected success but instead got \(reply)")
            }
        })
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_biometric_deliversSuccessWithFalse() {
        let contextStub = LAContextStub(result: .success(false))
        
        let exp = expectation(description: "wait for auth")
        Biometrical.context(contextStub).verify(completion: { reply in
            exp.fulfill()
            switch reply {
            case .success(let success):
                XCTAssertEqual(false, success)
            case .failure:
                XCTFail("expected success but instead got \(reply)")
            }
        })
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_biometric_deliversFailure() {
        let anyError = NSError(domain: "any Error", code: 0)
        let contextStub = LAContextStub(result: .failure(anyError))
        
        let exp = expectation(description: "wait for auth")
        Biometrical.context(contextStub).verify(completion: { reply in
            exp.fulfill()
            switch reply {
            case .success:
                XCTFail("expected failure but instead got \(reply)")
            case .failure(let error):
                XCTAssertEqual(anyError.localizedDescription, error.localizedDescription)
            }
        })
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_biometric_deliversSuccessFalseWhenPolicyIsNotAvailable() {
        let contextStub = LAContextStub(policy: .deviceOwnerAuthenticationWithBiometrics,
                                        result: .success(false))
        
        let exp = expectation(description: "wait for auth")
        Biometrical.context(contextStub).verify(completion: { reply in
            exp.fulfill()
            switch reply {
            case .success(let success):
                XCTAssertEqual(false, success)
            case .failure:
                XCTFail("expected success but instead got \(reply)")
            }
        })
        wait(for: [exp], timeout: 1.0)
    }
}


private class LAContextStub: LAContext {
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

