//
//  VehicleView.swift
//  RentCar
//
//  Created by Jastin on 21/6/21.
//

import UIKit

class VehicleView: UIView {
    
    override func layoutSubviews() {
        
        self.backgroundColor = .white

        self.layer.cornerRadius = 10.0

        self.layer.shadowColor = UIColor.gray.cgColor

        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)

        self.layer.shadowRadius = 6.0

        self.layer.shadowOpacity = 0.7
    }
}
