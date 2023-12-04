//
//  PageQueryParameter.swift
//  PresentationLayer
//
//  Created by Jastin on 4/12/23.
//

import Foundation

public final class PageQueryParameter {
    
    private var number: Int
    
    public init(number: Int = 1) {
        self.number = number
    }
    
    public var current: [String: Int] {
        return ["page": number]
    }
    
    func goNext() {
        number += 1
    }
    
    func goBack() {
        number -= 1
    }
    
    func reset() {
        number = 1
    }
}
