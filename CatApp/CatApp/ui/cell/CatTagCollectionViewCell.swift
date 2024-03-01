//
//  CatTagCollectionViewCell.swift
//  CatApp
//
//  Created by Jastin on 1/3/24.
//

import Foundation
import UIKit

class CatTagCollectionViewCell: UICollectionViewCell, IdentifiableCell {
    
    private let tagLabel: UILabel = {
        let xTagLabel = UILabel()
        xTagLabel.translatesAutoresizingMaskIntoConstraints = false
        return xTagLabel
    }()
    
    private let tagView: UIView = {
        let xTagView = UIView()
        xTagView.translatesAutoresizingMaskIntoConstraints = false
        xTagView.layer.borderWidth = 1
        xTagView.layer.borderColor = UIColor.systemBlue.cgColor
        xTagView.layer.cornerRadius = 5
        return xTagView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        onCreate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func onCreate() {
        setToSubView()
        setLayoutConstraint()
    }
    
    private func setToSubView() {
        addSubview(tagView)
        addSubview(tagLabel)
    }
    
    private func setLayoutConstraint() {
        NSLayoutConstraint.activate([tagLabel.topAnchor.constraint(equalTo: tagView.layoutMarginsGuide.topAnchor),
                                     tagLabel.leadingAnchor.constraint(equalTo: tagView.layoutMarginsGuide.leadingAnchor),
                                     tagLabel.trailingAnchor.constraint(equalTo: tagView.layoutMarginsGuide.trailingAnchor),
                                     tagLabel.bottomAnchor.constraint(equalTo: tagView.layoutMarginsGuide.bottomAnchor)])
        
        NSLayoutConstraint.activate([tagView.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     tagView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     tagView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
                                     tagView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)])
    }
    
    func setTag(_ tag: String) {
        tagLabel.text = tag
    }
}
