//
//  AppComposerTests.swift
//  TVShowAppTests
//
//  Created by Jastin Martínez on 20/11/23.
//

import XCTest
import TVShowApp
import Foundation
import LocalAuthentication


final class AppComposerTests: XCTestCase {

    func test_appComposer_canSetRootViewController() {
        let sut = makeSUT()
        
        sut.setUpApp()

        XCTAssertNotNil(sut.window.rootViewController)
        XCTAssertTrue(sut.window.rootViewController?.isViewLoaded ?? false)
    }

    func test_whenMainLoad_hasRequiredViewControllers() {
        let sut = makeSUT()
        
        sut.setUpApp()

        guard let mainTabBarViewController = sut.window.rootViewController as? MainTabBarViewController else {
            XCTFail("expected root to be \(String(describing: MainTabBarViewController.self))")
            return
        }
        XCTAssertTrue(mainTabBarViewController.viewControllers?.first is UINavigationController)
        XCTAssertTrue(mainTabBarViewController.viewControllers?.last is ConfigurationViewController)
    }
    
    func test_whenMainLoadWithNotAuth_continueToMain() {
        let mockStore = MockStore(key: .biometric, state: false)
        let sut = makeSUT(localStore: mockStore, biometricResult: .success(false))
        
        sut.setUpApp()
        
        guard let mainTabBarViewController = sut.window.rootViewController as? MainTabBarViewController else {
            XCTFail("expected root to be \(String(describing: MainTabBarViewController.self))")
            return
        }
        XCTAssertTrue(mainTabBarViewController.viewControllers?.first is UINavigationController)
        XCTAssertTrue(mainTabBarViewController.viewControllers?.last is ConfigurationViewController)
        
    }
    
    func test_whenMainLoadWithAuth_andBiometricIsNotSet_DisplayDeniedAccess() {
        let mockStore = MockStore(key: .biometric, state: true)
        let sut = makeSUT(localStore: mockStore, biometricResult: .success(false))
        
        sut.setUpApp()
        
        XCTAssertTrue(sut.window.rootViewController is DeniedAccessViewController)
    }
    
    func test_whenMainLoadWithAuth_andBiometricIsSet_MainView() {
        let mockStore = MockStore(key: .biometric, state: true)
        let sut = makeSUT(localStore: mockStore, biometricResult: .success(true))
        
        sut.setUpApp()
        
        XCTAssertTrue(sut.window.rootViewController is MainTabBarViewController)
    }
    
    func test_whenMainLoadWithAuth_andBiometricIsFailure_DisplayDeniedAccess() {
        let anyError = NSError(domain: "any error", code: 0)
        let mockStore = MockStore(key: .biometric, state: true)
        let sut = makeSUT(localStore: mockStore, biometricResult: .failure(anyError))
        
        sut.setUpApp()
        
        XCTAssertTrue(sut.window.rootViewController is DeniedAccessViewController)
    }

    private func makeSUT() -> AppComposer {
        return makeSUT(localStore: MockStore(), biometricResult: .success(true))
    }
    
    private func makeSUT(localStore: LocalStore, biometricResult: Result<Bool, Error>) -> AppComposer {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let localStorer = LocalStorer(localStore: localStore)
        let contextStub = LAContextStub(result: biometricResult)
        let biometricManager = BiometricManager(context: contextStub,
                                                localStorer: localStorer)
        let appComposer = AppComposer(window: window,
                                      biometricManager: biometricManager)
        return appComposer
    }
}
