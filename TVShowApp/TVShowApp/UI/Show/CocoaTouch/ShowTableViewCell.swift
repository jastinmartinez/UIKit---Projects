//
//  ShowTableViewCell.swift
//  TVShowApp
//
//  Created by Jastin on 3/4/22.
//

import UIKit
import DomainLayer

protocol DidChangeShowEntity : AnyObject {
    func didChangeShowEntity(_ showEntity: ShowEntity)
}

class ShowTableViewCell : UITableViewCell {
    private var showEntity: ShowEntity?
    weak var didChangeShowEntity: DidChangeShowEntity?
    private var showRatingButtonImageList = [UIButton]()
    private var showGenreLabelList = [UILabel]()
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        var configuration = UIButton.Configuration.plain()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setImage(UIImage(systemName: "heart.fill"), for: .selected)
        return button
    }()
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = UIFont(name: "avenir", size: 20)
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = UIColor(named: ColorHelper.blue.rawValue)!
        return titleLabel
    }()
    
    private lazy var posterImageView: UIImageView = {
        let posterImageView = UIImageView()
        posterImageView.image = .init(systemName: "circle.dashed")
        posterImageView.contentMode = .scaleAspectFill
        return posterImageView
    }()
    
    private lazy var ratingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        for index in 1...10 {
            let ratingButtonImage = UIButton()
            ratingButtonImage.tintColor = UIColor(named: ColorHelper.red.rawValue)
            ratingButtonImage.setImage(UIImage(systemName: "star.fill"), for: .selected)
            ratingButtonImage.setImage(UIImage(systemName: "star"), for: .normal)
            self.showRatingButtonImageList.append(ratingButtonImage)
            stackView.addArrangedSubview(ratingButtonImage)
        }
        return stackView
    }()
    
    private lazy var genreStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        for index in 1...3 {
            let genreLabel = UILabel()
            genreLabel.font = UIFont(name: "avenir", size: 15)
            genreLabel.textColor = UIColor(named: ColorHelper.blue.rawValue)!
            self.showGenreLabelList.append(genreLabel)
            stackView.addArrangedSubview(genreLabel)
        }
        return stackView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setTableViewCellConfiguration()
        self.setOutletToSubView()
        self.setTitleLabelConstraint()
        self.setPosterImageViewConstraint()
        self.setRatingStackViewConstraint()
        self.setGenreStackViewConstraint()
        self.setFavoriteButtonConstraint()
    }
    
    fileprivate func setTableViewCellConfiguration() {
        self.backgroundColor = UIColor(named: ColorHelper.white.rawValue)!
    }
    
    fileprivate func setOutletToSubView() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.posterImageView)
        self.addSubview(self.ratingStackView)
        self.addSubview(self.genreStackView)
        self.addSubview(self.favoriteButton)
    }
    
    fileprivate func setTitleLabelConstraint() {
        NSLayoutConstraint.on([self.titleLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
                               self.titleLabel.leftAnchor.constraint(equalTo: self.posterImageView.rightAnchor,constant: 10),
                               self.titleLabel.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor)])
    }
    
    fileprivate func setPosterImageViewConstraint() {
        NSLayoutConstraint.on([self.posterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                               self.posterImageView.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor),
                               self.posterImageView.heightAnchor.constraint(equalToConstant: 130),
                               self.posterImageView.widthAnchor.constraint(equalToConstant: 130)])
    }
    
    fileprivate func setRatingStackViewConstraint() {
        NSLayoutConstraint.on([
            self.ratingStackView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,constant: 10),
            self.ratingStackView.leftAnchor.constraint(equalTo: self.posterImageView.rightAnchor,constant: 10),
            self.ratingStackView.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor,constant: -10)])
    }
    
    fileprivate func setGenreStackViewConstraint() {
        NSLayoutConstraint.on([
            self.genreStackView.topAnchor.constraint(equalTo: self.ratingStackView.bottomAnchor,constant: 10),
            self.genreStackView.leftAnchor.constraint(equalTo: self.posterImageView.rightAnchor,constant: 10)])
    }
    
    func setShowEntity(_ showEntity: ShowEntity) {
        self.showEntity = showEntity
        DispatchQueue.main.async {
            self.setGenreLabelListValue(showEntity)
            self.setRatingButtonImageListValue(showEntity)
            self.titleLabel.text = showEntity.name
            if let imageData = showEntity.image?.data {
                self.posterImageView.image = UIImage(data: imageData)
            }
            self.favoriteButton.isSelected = showEntity.isFavorite
        }
    }
    
    fileprivate func setGenreLabelListValue(_ showEntity: ShowEntity) {
        let lastIndex = showEntity.genres.count - 1
        for index in 0...2 {
            if index <= lastIndex {
                self.showGenreLabelList[index].text = showEntity.genres[index]
            }
        }
    }
    
    fileprivate func setRatingButtonImageListValue(_ showEntity: ShowEntity) {
        if let rating = showEntity.rating.average{
            for index in 0...Int(rating) {
                self.showRatingButtonImageList[index].isSelected = true
            }
        }
    }
    
    @objc fileprivate func favoriteButtonTouch(sender: UIButton) {
        DispatchQueue.main.async {
            self.favoriteButton.isSelected.toggle()
            self.showEntity?.isFavorite.toggle()
            guard let showEntity = self.showEntity else {
                return
            }
            self.didChangeShowEntity?.didChangeShowEntity(showEntity)
        }
    }
    
    fileprivate func setFavoriteButtonConstraint() {
        self.favoriteButton.addTarget(self, action: #selector(favoriteButtonTouch), for: .touchUpInside)
        NSLayoutConstraint.on([self.favoriteButton.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor),
                               self.favoriteButton.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
                               self.favoriteButton.heightAnchor.constraint(equalToConstant: 50),
                               self.favoriteButton.widthAnchor.constraint(equalToConstant: 50)])
    }
}
