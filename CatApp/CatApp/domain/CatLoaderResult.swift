//
//  CatLoaderResult.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import Foundation

public enum CatLoaderResult {
    case success([Cat])
    case failure(Error)
}
