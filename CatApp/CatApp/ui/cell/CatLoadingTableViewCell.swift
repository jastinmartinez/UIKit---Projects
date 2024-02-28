//
//  CatLoadingTableViewCell.swift
//  CatApp
//
//  Created by Jastin on 28/2/24.
//

import Foundation
import UIKit

public class CatLoadingTableViewCell: UITableViewCell, IdentifiableCell { 
    
    private let loadingIndicatorView: UIActivityIndicatorView = {
        let xLoadingIndicatorView = UIActivityIndicatorView(style: .large)
        xLoadingIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        xLoadingIndicatorView.startAnimating()
        return xLoadingIndicatorView
    }()
    
    private let catPlaceHolderImageView: UIImageView = {
        let xCatPlaceHolderImageView = UIImageView()
        xCatPlaceHolderImageView.translatesAutoresizingMaskIntoConstraints = false
        xCatPlaceHolderImageView.image = UIImage(named: "catplaceholder")
        return xCatPlaceHolderImageView
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        onCreate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        startLoading()
    }
    
    private func onCreate() {
        setToSubView()
        setConstraint()
    }
    
    private func setToSubView() {
        addSubview(loadingIndicatorView)
        addSubview(catPlaceHolderImageView)
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([loadingIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     loadingIndicatorView.topAnchor.constraint(equalTo: catPlaceHolderImageView.bottomAnchor)])
        
        NSLayoutConstraint.activate([catPlaceHolderImageView.heightAnchor.constraint(equalToConstant: 50),
                                     catPlaceHolderImageView.widthAnchor.constraint(equalToConstant: 50),
                                     catPlaceHolderImageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                                     catPlaceHolderImageView.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
    private func startLoading() {
        loadingIndicatorView.startAnimating()
    }
}
