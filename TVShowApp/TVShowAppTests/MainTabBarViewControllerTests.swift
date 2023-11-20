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
}
