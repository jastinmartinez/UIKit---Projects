//
//  RoundedButton.swift
//  RentCar
//
//  Created by Jastin on 17/5/21.
//

import UIKit

class RoundedButton: UIButton {

    override func awakeFromNib() {
        layer.cornerRadius = frame.size.height / 2
        clipsToBounds = true
    }
}
