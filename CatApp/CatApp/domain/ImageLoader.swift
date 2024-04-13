//
//  ImageLoader.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import Foundation

public protocol ImageLoader {
    func load(from url: URL, completion: @escaping (ImageLoaderResult) -> Void)
}

