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
        
        Biometric.context(contextStub).verify(completion: {_ in})
        
        XCTAssertEqual(LAPolicy.deviceOwnerAuthentication, contextStub.policy)
    }
    
    func test_biometric_receivedReasonWhyIsRequired() {
        let contextStub = LAContextStub(result: .success(true))
        
        Biometric.context(contextStub).verify(completion: {_ in})
        
        XCTAssertEqual("Log in with" + contextStub.localizedReason, contextStub.reason)
    }
    
    func test_biometric_deliversSuccessWithTrue() {
        let contextStub = LAContextStub(result: .success(true))
        
        let exp = expectation(description: "wait for auth")
        Biometric.context(contextStub).verify(completion: { reply in
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
        Biometric.context(contextStub).verify(completion: { reply in
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
        Biometric.context(contextStub).verify(completion: { reply in
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
        Biometric.context(contextStub).verify(completion: { reply in
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

