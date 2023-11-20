//
//  TVShowAppTests.swift
//  TVShowAppTests
//
//  Created by Jastin Martínez on 20/11/23.
//

import XCTest
@testable import TVShowApp

final class MainTabBarViewControllerTests: XCTestCase {

    func test_whenMainLoad_ShouldSetShowViewControllers() {
        let requiredViewControllers = [UIViewController(), UIViewController()]
        let sut = MainTabBarViewController(viewControllers: requiredViewControllers)

        sut.loadViewIfNeeded()

        XCTAssertEqual(sut.viewControllers?.count, 2)
    }

    func test_whenMainLoad_VisualPropertiesAreSetCorrectly() {
        let sut = MainTabBarViewController(viewControllers: [])

        sut.loadViewIfNeeded()

        XCTAssertFalse(sut.tabBar.isTranslucent)
        XCTAssertTrue(UIColor(named: ColorHelper.red.rawValue)!.isEqual(sut.tabBar.tintColor))
        XCTAssertTrue(UIColor(named: ColorHelper.blue.rawValue)!.isEqual(sut.view.backgroundColor))
    }
}
