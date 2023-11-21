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
    
    func test_whenMainWithAuthLoad_VerifyBiometrics() {
        let sut = makeSUT()
        sut.setUpApp()
        
        
    }

    private func makeSUT() -> AppComposer {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let userDefault = UserDefaults.standard
        let localStorer = LocalStorer(localStore: userDefault)
        let appComposer = AppComposer(window: window, localStorer: localStorer)
        return appComposer
    }
}
