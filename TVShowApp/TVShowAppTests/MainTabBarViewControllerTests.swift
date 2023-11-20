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

        XCTAssertEqual(sut.viewControllers?.count, 2)
    }

    func test_whenMainLoad_VisualPropertiesAreSetCorrectly() {
        let sut = MainTabBarViewController(viewControllers: [])

        XCTAssertFalse(sut.tabBar.isTranslucent)
        XCTAssertTrue(UIColor(named: ColorHelper.red.rawValue)!.isEqual(sut.tabBar.tintColor))
        XCTAssertTrue(UIColor(named: ColorHelper.blue.rawValue)!.isEqual(sut.view.backgroundColor))
    }

    func test_whenMainLoad_HasRequiredViewControllers() {
        let sut = MainTabBarViewController(viewControllers: [])

        sut.viewDidLoad()

        XCTAssertTrue(sut.viewControllers?.first is UINavigationController)
        XCTAssertTrue(sut.viewControllers?.last is ConfigurationViewController)
    }
}
