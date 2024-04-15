//
//  CatTableViewCell.swift
//  CatApp
//
//  Created by Jastin on 28/2/24.
//

import Foundation
import UIKit

public class CatTableViewCell: UITableViewCell, IdentifiableCell {
    
    private(set) public lazy var containerView: UIView = {
       return UIView()
    }()
    
    private(set) public lazy var retryButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var onRetry: (() -> Void)?
    
    private(set) public lazy var catImageView: UIImageView = {
        let xCatImageView = UIImageView()
        xCatImageView.layer.masksToBounds = true
        xCatImageView.layer.cornerRadius = 20
        xCatImageView.translatesAutoresizingMaskIntoConstraints = false
        return xCatImageView
    }()
    
    public private(set) var tagComponents = [(label: UILabel, view: UIView)]()
    
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
        setTagView()
    }
    
    @objc private func retryButtonTapped() {
        onRetry?()
    }
    
    private func setToSubView() {
        addSubview(catImageView)
    }
    
    private func setLayout() {
        selectionStyle = .none
        accessoryType = .disclosureIndicator
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([catImageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                                     catImageView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
                                     catImageView.heightAnchor.constraint(equalToConstant: 70),
                                     catImageView.widthAnchor.constraint(equalToConstant: 70)])
    }
    
    func setTags(_ tags: [String]?) {
        if let tags = tags {
            for index in 0..<min(3,tags.count) {
                tagComponents[index].label.text = tags[index]
                tagComponents[index].view.isHidden = false
            }
        }
    }
    
    private func setTagView() {
        let tagStackView = tagStackViewFactory()
        for _ in 0..<3 {
            let tagLabel = tagLabelFactory()
            let tagView = tagViewFactory()
            tagView.addSubview(tagLabel)
            tagStackView.addArrangedSubview(tagView)
            NSLayoutConstraint.activate([tagLabel.topAnchor.constraint(equalTo: tagView.layoutMarginsGuide.topAnchor),
                                         tagLabel.leadingAnchor.constraint(equalTo: tagView.layoutMarginsGuide.leadingAnchor),
                                         tagLabel.trailingAnchor.constraint(equalTo: tagView.layoutMarginsGuide.trailingAnchor),
                                         tagLabel.bottomAnchor.constraint(equalTo: tagView.layoutMarginsGuide.bottomAnchor)])
            tagComponents.append((tagLabel, tagView))
        }
        addSubview(tagStackView)
        NSLayoutConstraint.activate([tagStackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
                                     tagStackView.leadingAnchor.constraint(equalTo: catImageView.trailingAnchor, constant: 10),
                                     tagStackView.trailingAnchor.constraint(lessThanOrEqualTo: layoutMarginsGuide.trailingAnchor),
                                     tagStackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)])
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
    
    private func tagLabelFactory() -> UILabel {
        let tagLabel = UILabel()
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        return tagLabel
    }
    
    private func tagViewFactory() -> UIView {
        let tagView = UIView()
        tagView.isHidden = true
        tagView.translatesAutoresizingMaskIntoConstraints = false
        tagView.layer.borderWidth = 1
        tagView.layer.borderColor = UIColor.systemBlue.cgColor
        tagView.layer.cornerRadius = 5
        return tagView
    }
}
