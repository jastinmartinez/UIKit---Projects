//
//  CatViewController.swift
//  CatAppTests
//
//  Created by Jastin on 1/3/24.
//

import Foundation
import CatApp
import XCTest


final class CatViewControllerTests: XCTestCase {
    
    func test_onInit_requiredACat() {
        let cat = Cat(id: "someId", size: 1029, tags: ["Cute", "Ugly", "Demo"], image: UIImage(systemName: "circle")?.pngData())
        let sut = CatViewController(cat: cat)
        
        sut.loadViewIfNeeded()
        
        XCTAssertTrue(sut.isViewLoaded)
    }
}
