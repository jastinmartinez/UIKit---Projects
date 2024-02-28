//
//  FactoryHelpers.swift
//  CatAppTests
//
//  Created by Jastin on 27/2/24.
//

import Foundation
import CatApp

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

func makeCats() -> [Cat] {
    return [Cat(id: "7RxMRzAMC39q879v",
                size: 11728,
                tags: ["cute"]),
            Cat(id: "vMacnX3oi0XtcTNB",
                size: 19949,
                tags: ["cute"]),
            Cat(id: "wINuKui2s7xdsBqV",
                size: 17159,
                tags: ["cute", "housemaid"])]
}
