//
//  ShowEpisodeTest.swift
//  DataLayerTests
//
//  Created by Jastin on 5/4/22.
//

import XCTest
@testable import DataLayer

class ShowEpisodeTest: XCTestCase {

    func test_ShowEpisodeRemoteDataSource_WhenGivenSuccess_ReturnShowEpisodeModelList() {
        let expectation = self.expectation(description: "test_ShowEpisodeRemoteDataSource_WhenGivenSuccess_ReturnShowEpisodeModelList")
        let showEpisodeRemoteDataSource = ShowEpisodeRemoteDataSource(baseUrl: "https://api.tvmaze.com/shows",resource: "episodes")
        showEpisodeRemoteDataSource.fecthShowEpisodeList(showId: 1) { dataResponse in
            switch dataResponse.result {
            case .success(let response):
                XCTAssertFalse(response.isEmpty)
                expectation.fulfill()
            case .failure(_):
                break
            }
        }
        self.wait(for: [expectation], timeout: 3)
    }
    
    func test_ShowEpisodeRemoteDataSource_WhenGivenIncorrectUrl_ReturnShowEpisodeModelListEmpty() {
        let expectation = self.expectation(description: "test_ShowEpisodeRemoteDataSource_WhenGivenIncorrectUrl_ReturnShowEpisodeModelListEmpty")
        let showEpisodeRemoteDataSource = ShowEpisodeRemoteDataSource(baseUrl: "https://api.tvmaze.com/sh1ows",resource: "episodes")
        showEpisodeRemoteDataSource.fecthShowEpisodeList(showId: 1) { dataResponse in
            switch dataResponse.result {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertNotNil(error.errorDescription)
                expectation.fulfill()
            }
        }
        self.wait(for: [expectation], timeout: 3)
    }
    
    
    func test_ShowEpisodeDataRepository_WhenGivenIncorrectUrl_ReturnShowEpisodeEntityListEmpty() {
        let expectation = self.expectation(description: "test_ShowEpisodeDataRepository_WhenGivenIncorrectUrl_ReturnShowEpisodeEntityListEmpty")
        let showEpisodeRemoteDataSource = ShowEpisodeRemoteDataSource(baseUrl: "https://api.tvmaze.com/sh1ows",resource: "episodes")
        let showEpisodeDataRepository = ShowEpisodeDataRepository(showEpisodeRemoteDataSourceProtocol: showEpisodeRemoteDataSource)
         showEpisodeDataRepository.fetchShowEpisodeList(showId: 1) { dataResponse in
             switch dataResponse {
            case .success(_):
                 break
            case .failure(let error):
                 XCTAssertNotNil(error.errorDescription)
                 expectation.fulfill()
            }
        }
        self.wait(for: [expectation], timeout: 3)
    }
    
    func test_ShowEpisodeDataRepository_WhenGivenSuccess_ReturnShowEpisodeEntityList() {
        let expectation = self.expectation(description: "test_ShowEpisodeDataRepository_WhenGivenSuccess_ReturnShowEpisodeEntityList")
        let showEpisodeRemoteDataSource = ShowEpisodeRemoteDataSource(baseUrl: "https://api.tvmaze.com/shows",resource: "episodes")
        let showEpisodeDataRepository = ShowEpisodeDataRepository(showEpisodeRemoteDataSourceProtocol: showEpisodeRemoteDataSource)
         showEpisodeDataRepository.fetchShowEpisodeList(showId: 1) { dataResponse in
             switch dataResponse {
            case .success(let response):
                XCTAssertFalse(response.isEmpty)
                 expectation.fulfill()
            case .failure(_):
                break
            }
        }
        self.wait(for: [expectation], timeout: 3)
    }
}
