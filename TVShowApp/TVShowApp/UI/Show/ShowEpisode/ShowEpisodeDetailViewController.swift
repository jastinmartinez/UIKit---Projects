//
//  ShowEpisodeDetail.swift
//  TVShowApp
//
//  Created by Jastin on 5/4/22.
//

import UIKit
import DomainLayer

class ShowEpisodeDetailViewController : UIViewController {
    
    private var showEpisodeEntity: ShowEpisodeEntity!
    private lazy var nameLabel: UILabel = UILabel.buildLabelWith(size: 30,color: .white, isMultiline: true,textAligment: .center)
    private lazy var summaryLabel: UILabel = UILabel.buildLabelWith(size: 15,color: .white, isMultiline: true,textAligment: .center)
    private lazy var numberLabel: UILabel = UILabel.buildLabelWith(size: 15,color: .white, isMultiline: true,textAligment: .center)
    private lazy var seasonLabel: UILabel = UILabel.buildLabelWith(size: 15,color: .white, isMultiline: true,textAligment: .center)
    private lazy var posterImageView = UIImageView.buidlPosterImage()
    private lazy var ratingStackView = UIStackView.buildRating(rating: Int(showEpisodeEntity.rating.average ?? 0))
    
    init(showEpisodeEntity: ShowEpisodeEntity) {
        self.showEpisodeEntity = showEpisodeEntity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewConfiguration()
        self.setOutletToSubView()
        self.setPosterImageView()
        self.setNameLabel()
        self.setRatingStackViewConstraint()
        self.setSeasonLabel()
        self.setNumberLabel()
        self.setSummaryLabel()
    }
    
    fileprivate func setViewConfiguration() {
        self.view.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)
    }
    
    fileprivate func setOutletToSubView() {
        self.view.addSubview(self.nameLabel)
        self.view.addSubview(self.summaryLabel)
        self.view.addSubview(self.numberLabel)
        self.view.addSubview(self.seasonLabel)
        self.view.addSubview(self.posterImageView)
        self.view.addSubview(self.ratingStackView)
    }
    
    fileprivate func setPosterImageView() {
        if let imagedata = showEpisodeEntity.image?.imageData {
            self.posterImageView.image = UIImage(data: imagedata)
        }
        NSLayoutConstraint.on([self.posterImageView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor,constant: 10),
                               self.posterImageView.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor),
                               self.posterImageView.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor),
                               self.posterImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor,multiplier: 1/2)])
    }
    
    fileprivate func setNameLabel() {
        self.nameLabel.text = showEpisodeEntity.name
        NSLayoutConstraint.on([self.nameLabel.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor,constant: 10),
                               self.nameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                               self.nameLabel.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor),
                               self.nameLabel.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor)])
    }
    
    fileprivate func setRatingStackViewConstraint() {
        NSLayoutConstraint.on([self.ratingStackView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor,constant: 10),
                               self.ratingStackView.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor),
                               self.ratingStackView.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor)])
    }
    
    fileprivate func setSeasonLabel() {
        self.seasonLabel.text = "Season \(showEpisodeEntity.season)"
        NSLayoutConstraint.on([self.seasonLabel.topAnchor.constraint(equalTo: self.ratingStackView.bottomAnchor,constant: 10),
                               self.seasonLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])
    }
    
    fileprivate func setNumberLabel() {
        self.numberLabel.text = "Number \(showEpisodeEntity.number)"
        NSLayoutConstraint.on([self.numberLabel.topAnchor.constraint(equalTo: self.seasonLabel.bottomAnchor,constant: 10),
                               self.numberLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)])
    }
    
    fileprivate func setSummaryLabel() {
        self.summaryLabel.text = showEpisodeEntity.summary ?? NameHelper.NotAvailable.rawValue
        NSLayoutConstraint.on([self.summaryLabel.topAnchor.constraint(equalTo: self.numberLabel.bottomAnchor,constant: 10),
                               self.summaryLabel.leftAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leftAnchor),
                               self.summaryLabel.rightAnchor.constraint(equalTo: self.view.layoutMarginsGuide.rightAnchor)])
    }
}
