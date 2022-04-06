//
//  UIActivityIndicatorView+Factory.swift
//  TVShowApp
//
//  Created by Jastin on 5/4/22.
//

import Foundation
import UIKit

extension UIActivityIndicatorView {
    class func buildActivityIndicator() ->  UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = UIColor(named: ColorHelper.red.rawValue)!
        return activityIndicator
    }
}
