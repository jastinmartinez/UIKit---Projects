//
//  CatLoader.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import Foundation

public protocol CatLoader {
    func load(completion: @escaping (CatLoaderResult) -> Void)
}
