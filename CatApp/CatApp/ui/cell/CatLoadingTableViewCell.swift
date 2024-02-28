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
        return xLoadingIndicatorView
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
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([loadingIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     loadingIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)])
    }
    private func startLoading() {
        loadingIndicatorView.startAnimating()
    }
}
