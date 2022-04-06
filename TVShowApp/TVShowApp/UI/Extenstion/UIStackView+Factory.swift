//
//  UIStackView+Factory.swift
//  TVShowApp
//
//  Created by Jastin on 5/4/22.
//

import UIKit
extension UIStackView {
    class func buildRating(rating: Int) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        for index in 1...10 {
            let ratingButtonImage = UIButton()
            ratingButtonImage.tintColor = UIColor(named: ColorHelper.red.rawValue)
            ratingButtonImage.setImage(UIImage(systemName: "star.fill"), for: .selected)
            ratingButtonImage.setImage(UIImage(systemName: "star"), for: .normal)
            if index <= rating {
                ratingButtonImage.isSelected = true
            }
            stackView.addArrangedSubview(ratingButtonImage)
        }
        return stackView
    }
}
