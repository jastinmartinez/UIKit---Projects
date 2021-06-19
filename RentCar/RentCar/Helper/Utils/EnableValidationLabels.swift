//
//  EnableAndDisableValidation.swift
//  RentCar
//
//  Created by Jastin on 19/6/21.
//

import Foundation
import UIKit

final class EnableValidationLabels {
    func enable(label: UILabel,message: String = "",setHidden: Bool = false) {
        label.isHidden = setHidden
        label.text = message
    }
}
