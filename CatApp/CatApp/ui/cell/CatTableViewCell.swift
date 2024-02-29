//
//  CatTableViewCell.swift
//  CatApp
//
//  Created by Jastin on 28/2/24.
//

import Foundation
import UIKit

public class CatTableViewCell: UITableViewCell, IdentifiableCell {
    
    let catImageView: UIImageView = {
        let xCatImageView = UIImageView()
        xCatImageView.layer.masksToBounds = true
        xCatImageView.layer.cornerRadius = 20
        xCatImageView.translatesAutoresizingMaskIntoConstraints = false
        return xCatImageView
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        onCreate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func onCreate() {
        setLayout()
        setToSubView()
        setConstraint()
    }
    
    private func setToSubView() {
        addSubview(catImageView)
    }
    
    private func setLayout() {
        selectionStyle = .none
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([catImageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                                     catImageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
                                     catImageView.heightAnchor.constraint(equalToConstant: 70),
                                     catImageView.widthAnchor.constraint(equalToConstant: 70)])
    }
    
    func setCat(_ cat: Cat) {
        
    }
    
    func setCatImage(_ image: DataStatePresenter<Data>) {
        DispatchQueue.main.async { [catImageView] in
            switch image {
            case .loading:
                catImageView.image = UIImage(named: AssetConstant.catPlaceholder.rawValue)
            case .success(let data):
                if let image = UIImage(data: data) {
                    catImageView.image = image
                } else {
                    catImageView.image = UIImage(named: AssetConstant.catNotFound.rawValue)
                }
            case .failure:
                catImageView.image = UIImage(named: AssetConstant.catNotFound.rawValue)
            }
        }
    }
}
