//
//  ShowTest.swift
//  dataTests
//
//  Created by Jastin on 2/4/22.
//

import XCTest
@testable import data

// MARK: For DATA test is required internet access
class ShowTest: XCTestCase {
    
    private var sutShowRemoteDataSource: ShowRemoteDataSource!
    private var baseUrl: String!
    
    override func setUp() {
        super.setUp()
        self.baseUrl = "https://api.tvmaze.com/shows"
        self.sutShowRemoteDataSource = ShowRemoteDataSource(baseUrl: baseUrl)
    }
    
    override func tearDown() {
        super.tearDown()
        self.sutShowRemoteDataSource = nil
        self.baseUrl = nil
    }
    
    func test_ShowRemoteDataSource_WhenGivenSuccesResponse_returnShowModelList() {
        let expectation = self.expectation(description: "Fetching Show Model List")
        self.sutShowRemoteDataSource.fetchShowList { dataResponse in
           let result = try? dataResponse.result.get()
            XCTAssertNotNil(result)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 3)
    }
    
    func testShowDataRespository_WhenGivenSuccesResponse_ReturnShowModelLisToShowModeEntityList() {
        let expectation = self.expectation(description: "Fetching Show Model List and Convert to Show Model Entity")
        let sutShowDataRepository = ShowDataRepository(showRemoteDataSource: sutShowRemoteDataSource)
        sutShowDataRepository.fetchShowList { showEntity in
            XCTAssertNotNil(try? showEntity.get())
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 3)
    }
    
    func testShowRemoteDataSource_WhenGivenErrorResponse_ReturnError() {
        let expectation = self.expectation(description: "Fetching with errors")
        self.sutShowRemoteDataSource = ShowRemoteDataSource(baseUrl: self.baseUrl + "Fail")
        self.sutShowRemoteDataSource.fetchShowList { dataResponse in
            XCTAssertNotNil(dataResponse.error)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 3)
    }
    
    func testShowDataRepository_WhenGivenErrorResponse_ReturnDomainError() {
        let expectation = self.expectation(description: "Fetching with errors")
        self.sutShowRemoteDataSource = ShowRemoteDataSource(baseUrl: self.baseUrl + "Fail")
        let sutShowDataRepository = ShowDataRepository(showRemoteDataSource: sutShowRemoteDataSource)
        sutShowDataRepository.fetchShowList { showEntity in
            XCTAssertNil(try? showEntity.get())
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 3)
    }
}
