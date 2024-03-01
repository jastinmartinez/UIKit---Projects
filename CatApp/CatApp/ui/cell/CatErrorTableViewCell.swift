//
//  CatErrorTableViewCell.swift
//  CatApp
//
//  Created by Jastin on 28/2/24.
//

import UIKit

public class CatErrorTableViewCell: UITableViewCell, IdentifiableCell {
    
    
    private let errorLabel: UILabel = {
        let xErrorLabel = UILabel()
        xErrorLabel.text =  "Uh oh there's an issue"
        xErrorLabel.translatesAutoresizingMaskIntoConstraints = false
        return xErrorLabel
    }()
    
    private let catPlaceHolderImageView: UIImageView = {
        let xCatPlaceHolderImageView = UIImageView()
        xCatPlaceHolderImageView.translatesAutoresizingMaskIntoConstraints = false
        xCatPlaceHolderImageView.image = UIImage(named: AssetConstant.catNotFound.rawValue)
        return xCatPlaceHolderImageView
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        onCreate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func onCreate() {
        setToSubView()
        setConstraint()
        setLayout()
    }
    
    private func setToSubView() {
        addSubview(errorLabel)
        addSubview(catPlaceHolderImageView)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([catPlaceHolderImageView.heightAnchor.constraint(equalToConstant: 50),
                                     catPlaceHolderImageView.widthAnchor.constraint(equalToConstant: 50),
                                     catPlaceHolderImageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                                     catPlaceHolderImageView.centerXAnchor.constraint(equalTo: centerXAnchor)])
        
        NSLayoutConstraint.activate([errorLabel.topAnchor.constraint(equalTo: catPlaceHolderImageView.bottomAnchor, constant: 10),
                                     errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
    
    private func setLayout() {
        selectionStyle = .none
        isUserInteractionEnabled = false
    }
}
