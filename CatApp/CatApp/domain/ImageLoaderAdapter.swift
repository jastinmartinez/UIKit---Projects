//
//  ImageLoaderAdapter.swift
//  CatApp
//
//  Created by Jastin on 29/2/24.
//

import Foundation

public protocol ImageLoaderTask {
    func cancel()
}

public protocol ImageLoaderAdapter {
    func load(from id: String, completion: @escaping (CatApp.ImageLoaderResult) -> Void) -> ImageLoaderTask
}
