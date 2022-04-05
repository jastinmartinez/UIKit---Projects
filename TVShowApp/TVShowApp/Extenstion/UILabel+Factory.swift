//
//  UILabel+Factory.swift
//  TVShowApp
//
//  Created by Jastin on 5/4/22.
//

import UIKit
extension UILabel {
    class func buildLabelWith(size: CGFloat, color: UIColor = .black, isMultiline: Bool = false,textAligment: NSTextAlignment = .natural) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Avenir", size: size)
        label.textColor = color
        label.numberOfLines = isMultiline ? 0 : 1
        label.textAlignment = textAligment
        return label
    }
}
