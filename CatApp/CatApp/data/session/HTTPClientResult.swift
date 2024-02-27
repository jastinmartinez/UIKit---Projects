//
//  HTTPClientResult.swift
//  CatApp
//
//  Created by Jastin on 27/2/24.
//

import Foundation

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}
