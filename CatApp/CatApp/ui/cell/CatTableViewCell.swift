//
//  CatTableViewCell.swift
//  CatApp
//
//  Created by Jastin on 28/2/24.
//

import Foundation
import UIKit

public class CatTableViewCell: UITableViewCell, IdentifiableCell {
    
    private let catImageView: UIImageView = {
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
        let tagStackView = tagStackViewFactory()
        if let tags = cat.tags {
            for index in 0..<min(3,tags.count) {
                setTagView(tags[index], tagStackView: tagStackView)
            }
        }
    }
    
    private func setTagView(_ tag: String, tagStackView: UIStackView) {
        let tagLabel = tagLabelFactory(with: tag)
        let tagView = tagViewFactory()
        tagView.addSubview(tagLabel)
        tagStackView.addArrangedSubview(tagView)
        NSLayoutConstraint.activate([tagLabel.topAnchor.constraint(equalTo: tagView.layoutMarginsGuide.topAnchor),
                                     tagLabel.leadingAnchor.constraint(equalTo: tagView.layoutMarginsGuide.leadingAnchor),
                                     tagLabel.trailingAnchor.constraint(equalTo: tagView.layoutMarginsGuide.trailingAnchor),
                                     tagLabel.bottomAnchor.constraint(equalTo: tagView.layoutMarginsGuide.bottomAnchor)])
        
        addSubview(tagStackView)
        NSLayoutConstraint.activate([tagStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                                     tagStackView.leadingAnchor.constraint(equalTo: catImageView.trailingAnchor, constant: 10)])
    }
    
    private func tagStackViewFactory() -> UIStackView {
        let tagStackView = UIStackView()
        tagStackView.translatesAutoresizingMaskIntoConstraints = false
        tagStackView.axis = .horizontal
        tagStackView.distribution = .fill
        tagStackView.alignment = .leading
        tagStackView.spacing = 5
        return tagStackView
    }
    
    private func tagLabelFactory(with text: String) -> UILabel {
        let tagLabel = UILabel()
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.text = text
        return tagLabel
    }
    
    private func tagViewFactory() -> UIView {
        let tagView = UIView()
        tagView.translatesAutoresizingMaskIntoConstraints = false
        tagView.layer.borderWidth = 1
        tagView.layer.borderColor = UIColor.systemBlue.cgColor
        tagView.layer.cornerRadius = 5
        return tagView
    }
    
    func setCatImage(_ image: DataStatePresenter<Data>) {
        DispatchQueue.main.async { [setImageFor] in
            setImageFor(image)
        }
    }
    
    private func setImageFor(_ state: DataStatePresenter<Data>) {
        switch state {
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
