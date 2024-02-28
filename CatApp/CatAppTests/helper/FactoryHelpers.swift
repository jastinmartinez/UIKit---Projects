//
//  FactoryHelpers.swift
//  CatAppTests
//
//  Created by Jastin on 27/2/24.
//

import Foundation


func anyURL() -> URL {
    return URL(string: "https://www.any-url.com")!
}

func anyError() -> Error {
    return NSError(domain: "any error", code: 0)
}

func anyData() -> Data {
    return Data()
}

func anyResponse(from url: URL, statusCode: Int) -> HTTPURLResponse {
    return HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: [:])!
}
