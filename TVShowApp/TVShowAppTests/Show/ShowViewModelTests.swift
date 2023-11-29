//
//  ShowViewModelTests.swift
//  TVShowAppTests
//
//  Created by Jastin on 27/11/23.
//

import Foundation
import XCTest
import TVShowApp
import DomainLayer
import PresentationLayer

public final class ShowViewModelTests: XCTestCase {
    
    func test_whenFetchShows_passParameter() {
        let anyParameter = anyParameter()
        let showInteractorMock = ShowInteractorMock(parameter: anyParameter, result: .success([]))
        let root = makeSUT(showInteractorMock)
        
        root.sut.fetchShows()
        
        XCTAssertEqual(root.show.parameter, anyParameter)
    }
    
    func test_whenFetchShowsWithParameter_deliversData() {
        let show = showEntity()
        let anyParameter = anyParameter()
        let showInteractorMock = ShowInteractorMock(parameter: anyParameter, result: .success([show]))
        let root = makeSUT(showInteractorMock)
        
        root.sut.fetchShows()
        
        XCTAssertEqual(root.show.parameter, anyParameter)
        if case let .success(shows) = root.show.result {
            XCTAssertEqual(shows.map({$0.id}), [show].map({$0.id}))
        } else {
            XCTFail("expected success but instead got \(root.show.result)")
        }
    }
    
    func test_whenFetchShowsWithParameter_deliversError() {
        let anyParameter = anyParameter()
        let showInteractorMock = ShowInteractorMock(parameter: anyParameter,
                                                    result: .failure(.NotValid))
        let root = makeSUT(showInteractorMock)
        
        expect(root, expect: .fail(DomainError.NotValid)) {
            root.sut.fetchShows()
        }
    }
    
    func test_whenFetchShowsWithParameter_notifyStateIsLoading() {
        let anyParameter = anyParameter()
        let showInteractorMock = ShowInteractorMock(parameter: anyParameter,
                                                    result: .failure(.NotValid))
        let root = makeSUT(showInteractorMock)
    
        expect(root, expect: .loading) {
            root.sut.fetchShows()
        }
    }
    
    func test_whenFetchShowsWithParameter_notifyStateIsDone() {
        let anyParameter = anyParameter()
        let showInteractorMock = ShowInteractorMock(parameter: anyParameter, result: .success([]))
        let root = makeSUT(showInteractorMock)
        
        expect(root, expect: .done) {
            root.sut.fetchShows()
        }
    }
    
    func test_whenFetchNextShow_notifyStateIsLoading() {
        let anyParameter = anyParameter()
        let showInteractorMock = ShowInteractorMock(parameter: anyParameter, result: .success([]))
        let root = makeSUT(showInteractorMock)
        
        expect(root, expect: .loading) {
            root.sut.fetchNextShows()
        }
    }

    
    private func makeSUT(_ showInteractorMock: ShowInteractorMock,
                         file: StaticString = #file,
                         line: UInt = #line) -> SUT {
        let externalImageInteractorMock = ExternalImageInteractorMock()
        let sut = ShowViewModel(showInteractorProtocol: showInteractorMock, externalImageInteractorProtocol: externalImageInteractorMock)
        trackForMemoryLeaks(instance: sut, file: file, line: line)
        return SUT(sut: sut, show: showInteractorMock)
    }
    
    private func expect(_ root: ShowViewModelTests.SUT,
                        expect: ShowViewModel.ShowState,
                        when action: @escaping () -> Void) {
        let exp = expectation(description: "wait for completion of \(expect)")
        root.sut.showsState = { state in
            if String(describing: state) == String(describing: expect) {
                exp.fulfill()
            }
        }
        action()
        wait(for: [exp], timeout: 1.0)
    }
    
    private func anyParameter() -> [String: Int] {
        return ["page": 1]
    }
    
    private func anyError() -> Error {
        return NSError(domain: "any error", code: 0)
    }
    
    private struct SUT {
        let sut: ShowViewModel
        let show: ShowInteractorMock
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

private class ShowInteractorMock: ShowInteractorProtocol {
    
    private(set) var parameter: [String: Int]
    let result: Result<[ShowEntity], DomainError>
    
    init(parameter: [String : Int],
         result: Result<[ShowEntity], DomainError>) {
        self.parameter = parameter
        self.result = result
    }
    func fetchShowList(queryParameter: Dictionary<String, Int>, handler: @escaping ((Result<[DomainLayer.ShowEntity], DomainLayer.DomainError>) -> Void)) {
        parameter = queryParameter
        handler(result)
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

private class ExternalImageInteractorMock: ExternalImageInteractorProtocol {
    func fetchExternalImage(imageUrl: String, handler: @escaping ((Result<Data?, DomainLayer.DomainError>) -> Void)) {
        
    }
}
