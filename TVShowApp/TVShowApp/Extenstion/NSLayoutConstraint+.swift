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
            (constraint.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
            constraint.isActive = true
        }
    }
}
