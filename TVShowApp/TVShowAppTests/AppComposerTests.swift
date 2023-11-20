//
//  AppComposerTests.swift
//  TVShowAppTests
//
//  Created by Jastin Martínez on 20/11/23.
//

import XCTest
import TVShowApp

final class AppComposerTests: XCTestCase {

    func test_appComposer_canSetRootViewController() {
        let sut = makeSUT()

        XCTAssertNotNil(sut.window.rootViewController)
        XCTAssertTrue(sut.window.rootViewController?.isViewLoaded ?? false)
    }

    func test_whenMainLoad_HasRequiredViewControllers() {
        let sut = makeSUT()

        guard let mainTabBarViewController = sut.window.rootViewController as? MainTabBarViewController else {
            XCTFail("expected root to be \(String(describing: MainTabBarViewController.self))")
            return
        }
        XCTAssertTrue(mainTabBarViewController.viewControllers?.first is UINavigationController)
        XCTAssertTrue(mainTabBarViewController.viewControllers?.last is ConfigurationViewController)
    }

    private func makeSUT() -> AppComposer {
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        let appComposer = AppComposer(window: window)
        return appComposer
    }
}
