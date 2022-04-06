//
//  NSLayoutconstraint+.swift
//  TVShowApp
//
//  Created by Jastin on 3/4/22.
//

import UIKit

extension NSLayoutConstraint {
    class func on(_ constraints:[NSLayoutConstraint]) {
        for constraint in constraints {
            guard let view = constraint.firstItem as? UIView else {
                return
            }
            view.translatesAutoresizingMaskIntoConstraints = false
            constraint.isActive = true
        }
    }
}
