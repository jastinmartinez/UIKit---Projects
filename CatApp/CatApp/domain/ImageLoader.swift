//
//  ImageLoader.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import Foundation

public protocol ImageLoader {
    typealias Result = Swift.Result<Data, Error>
    func load(from url: URL, completion: @escaping (Result) -> Void)
    func cancel()
}

