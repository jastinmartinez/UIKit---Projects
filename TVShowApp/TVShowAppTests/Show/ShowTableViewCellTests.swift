//
//  ShowTableViewCellTests.swift
//  TVShowAppTests
//
//  Created by Jastin on 26/11/23.
//

import Foundation
import XCTest
import DomainLayer
import TVShowApp


final class ShowTableViewCellTests: XCTestCase {
    
    func test_cell_canSetFavoriteShow() {
        let sut = makeSUT()
        let exp = expectation(description: "wait for isFavorite")
        
        sut.isFavorite = { showEntity in
            exp.fulfill()
            XCTAssertEqual(showEntity.id, showEntity.id)
            XCTAssertTrue(showEntity.isFavorite)
        }
        sut.setFavorite()
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_cell_canSetNotFavoriteShow() {
        let sut = makeSUT()
        let exp = expectation(description: "wait for isFavorite")
        
        sut.isFavorite = { showEntity in
            exp.fulfill()
            XCTAssertEqual(showEntity.id, showEntity.id)
            XCTAssertFalse(showEntity.isFavorite)
        }
        sut.setNotFavorite()
        wait(for: [exp], timeout: 1.0)
    }
    
    private func makeSUT() -> ShowTableViewCell {
        let showEntity = showEntity()
        let sut = ShowTableViewCell()
        sut.setShowEntity(showEntity)
        return sut
    }
    
    private func showEntity() -> ShowEntity {
        return ShowEntity(id: Int.random(in: 100...200),
                          name: "Kirby Buckets",
                          image:Optional(ShowImageEntity(original:"https://static.tvmaze.com/uploads/images/original_untouched/1/4600.jpg",
                                                         data: nil)),
                          schedule: ShowScheduleEntity(time: "07:00",
                                                       days: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]),
                          genres: ["Comedy"],
                          summary: Optional("<p>The single-camera series that mixes live-action and animation stars Jacob Bertrand as the title character. <b>Kirby Buckets</b> introduces viewers to the vivid imagination of charismatic 13-year-old Kirby Buckets, who dreams of becoming a famous animator like his idol, Mac MacCallister. With his two best friends, Fish and Eli, by his side, Kirby navigates his eccentric town of Forest Hills where the trio usually find themselves trying to get out of a predicament before Kirby\'s sister, Dawn, and her best friend, Belinda, catch them. Along the way, Kirby is joined by his animated characters, each with their own vibrant personality that only he and viewers can see.</p>"),
                          rating: ShowRatingEntity(average: nil))
    }
}
