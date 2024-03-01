//
//  CatItemImageLoader.swift
//  CatApp
//
//  Created by Jastin on 29/2/24.
//

import Foundation

public protocol CatItemImageLoader {
    func load(from id: String, completion: @escaping (CatApp.ImageLoaderResult) -> Void)
}
