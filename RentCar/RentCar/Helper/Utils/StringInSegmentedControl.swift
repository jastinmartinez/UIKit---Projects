//
//  SearchStringInSegmentedControl.swift
//  RentCar
//
//  Created by Jastin on 19/6/21.
//

import Foundation
import UIKit

final class StringInSegmentedControl {
    
    func search(_ text: String,segmentedControl: UISegmentedControl) -> Int {

        for index in 0...segmentedControl.numberOfSegments {
            if text == segmentedControl.titleForSegment(at: index)! {
                return index
            }
        }
        return -1
    }
}
