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
        let showInteractorMock = ShowInteractorMock(.success([]))
        let root = makeSUT(showInteractorMock)
        
        root.sut.fetchShows()
        
        XCTAssertEqual(root.show.parameter, anyParameter)
    }
    
    func test_whenFetchShowsWithParameter_deliversData() {
        let show = showEntity()
        let anyParameter = anyParameter()
        let showInteractorMock = ShowInteractorMock(.success([show]))
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
        let showInteractorMock = ShowInteractorMock(.failure(.NotValid))
        let root = makeSUT(showInteractorMock)
        
        expect(root, expect: .fail(DomainError.NotValid)) {
            root.sut.fetchShows()
        }
    }
    
    func test_whenFetchShowsWithParameter_notifyStateIsLoading() {
        let showInteractorMock = ShowInteractorMock(.failure(.NotValid))
        let root = makeSUT(showInteractorMock)
    
        expect(root, expect: .loading) {
            root.sut.fetchShows()
        }
    }
    
    func test_whenFetchShowsWithParameter_notifyStateIsDone() {
        let showInteractorMock = ShowInteractorMock(.success([]))
        let root = makeSUT(showInteractorMock)
        
        expect(root, expect: .done) {
            root.sut.fetchShows()
        }
    }
    
    func test_whenFetchNextShow_notifyStateIsLoading() {
        let showInteractorMock = ShowInteractorMock(.success([]))
        let root = makeSUT(showInteractorMock)
        
        expect(root, expect: .loading) {
            root.sut.fetchNextShows()
        }
    }
    
    func test_whenFetchNextShow_setQueryParameterPageIncreaseOnce() {
        let anyParameter = anyParameter(page: 2)
        let showInteractorMock = ShowInteractorMock( .success([]))
        let root = makeSUT(showInteractorMock)
        
        expect(root, expect: .loading) {
            root.sut.fetchNextShows()
            XCTAssertEqual(root.show.parameter, anyParameter)
        }
    }
    
    func test_whenFetchNextShowTwice_setQueryParameterPageIncreaseOnceTwice() {
        let showInteractorMock = ShowInteractorMock( .success([]))
        let root = makeSUT(showInteractorMock)
        
        let firstAnyExpected = anyParameter(page: 2)
        root.sut.fetchNextShows()
        XCTAssertEqual(root.pageQueryParameter.current, firstAnyExpected)
        
        let secondAnyExpected = anyParameter(page: 3)
        root.sut.fetchNextShows()
        XCTAssertEqual(root.pageQueryParameter.current, secondAnyExpected)
    }
    
    func test_whenFetchNextShowFails_setOldPageNumber() {
        let anyParameter = anyParameter(page: 1)
        let showInteractorMock = ShowInteractorMock( .failure(.NotValid))
        let root = makeSUT(showInteractorMock)
        
        root.sut.fetchNextShows()
        
        XCTAssertEqual(root.pageQueryParameter.current, anyParameter)
    }
    
    func test_whenFetchNextShowFails_setStateIsFailure() {
        let showInteractorMock = ShowInteractorMock( .failure(.NotValid))
        let root = makeSUT(showInteractorMock)
        
        root.sut.fetchNextShows()
        
        expect(root, expect: .fail(anyError())) {
            root.sut.fetchNextShows()
        }
    }
    
    func test_whenFetchNextShowSuccess_mapDataToExistingList() {
        let show = showEntity()
        let showInteractorMock = ShowInteractorMock(.success([show]))
        let root = makeSUT(showInteractorMock)
        
        root.sut.fetchShows()
        root.sut.fetchNextShows()
        
        XCTAssertEqual(root.sut.showEntities.map({$0.id}), [show, show].map({$0.id}))
    }

    
    private func makeSUT(_ showInteractorMock: ShowInteractorMock,
                         file: StaticString = #file,
                         line: UInt = #line) -> SUT {
        let pageQueryParameter = PageQueryParameter()
        let externalImageInteractorMock = ExternalImageInteractorMock()
        let sut = ShowViewModel(showInteractorProtocol: showInteractorMock, externalImageInteractorProtocol: externalImageInteractorMock, pageQueryParameter: pageQueryParameter)
        trackForMemoryLeaks(instance: sut, file: file, line: line)
        return SUT(sut: sut,
                   show: showInteractorMock,
                   pageQueryParameter: pageQueryParameter)
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
    
    private func anyParameter(page: Int = 1) -> [String: Int] {
        return ["page": page]
    }
    
    private func anyError() -> Error {
        return DomainError.NotValid
    }
    
    private struct SUT {
        let sut: ShowViewModel
        let show: ShowInteractorMock
        let pageQueryParameter: PageQueryParameter
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
    
    private(set) var parameter = [String: Int]()
    let result: Result<[ShowEntity], DomainError>
    
    init(_ result: Result<[ShowEntity], DomainError>) {
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
