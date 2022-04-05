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
        let showEpisodeRemoteDataSource = ShowEpisodeRemoteDataSource(baseUrl: "https://api.tvmaze.com/shows",resource: "episodes")
        showEpisodeRemoteDataSource.fecthShowEpisodeList(showId: 1) { dataResponse in
            switch dataResponse.result {
            case .success(let response):
                XCTAssertTrue(!response.isEmpty)
            case .failure(_):
                break
            }
        }
    }
    
    func test_ShowEpisodeRemoteDataSource_WhenGivenIncorrectUrl_ReturnShowEpisodeModelListEmpty() {
        let showEpisodeRemoteDataSource = ShowEpisodeRemoteDataSource(baseUrl: "https://api.tvmaze.com/sh1ows",resource: "episodes")
        showEpisodeRemoteDataSource.fecthShowEpisodeList(showId: 1) { dataResponse in
            switch dataResponse.result {
            case .success(let response):
                XCTAssertTrue(response.isEmpty)
            case .failure(_):
                break
            }
        }
    }
    
    
    func test_ShowEpisodeDataRepository_WhenGivenIncorrectUrl_ReturnShowEpisodeEntityListEmpty() {
        let showEpisodeRemoteDataSource = ShowEpisodeRemoteDataSource(baseUrl: "https://api.tvmaze.com/sh1ows",resource: "episodes")
        let showEpisodeDataRepository = ShowEpisodeDataRepository(showEpisodeRemoteDataSourceProtocol: showEpisodeRemoteDataSource)
         showEpisodeDataRepository.fetchShowEpisodeList(showId: 1) { dataResponse in
             switch dataResponse {
            case .success(let response):
                XCTAssertTrue(response.isEmpty)
            case .failure(_):
                break
            }
        }
    }
    
    func test_ShowEpisodeDataRepository_WhenGivenSuccess_ReturnShowEpisodeEntityList() {
        let showEpisodeRemoteDataSource = ShowEpisodeRemoteDataSource(baseUrl: "https://api.tvmaze.com/shows",resource: "episodes")
        let showEpisodeDataRepository = ShowEpisodeDataRepository(showEpisodeRemoteDataSourceProtocol: showEpisodeRemoteDataSource)
         showEpisodeDataRepository.fetchShowEpisodeList(showId: 1) { dataResponse in
             switch dataResponse {
            case .success(let response):
                XCTAssertTrue(!response.isEmpty)
            case .failure(_):
                break
            }
        }
    }
}
