//
//  UIImageView+Factory.swift
//  TVShowApp
//
//  Created by Jastin on 5/4/22.
//

import UIKit
extension UIImageView {
    class func buidlPosterImage() -> UIImageView {
        let posterImageView = UIImageView()
        posterImageView.image = .init(systemName: "circle.dashed")
        posterImageView.contentMode = .scaleToFill
        posterImageView.layer.cornerRadius = 30
        posterImageView.clipsToBounds = true
        return posterImageView
    }
}
