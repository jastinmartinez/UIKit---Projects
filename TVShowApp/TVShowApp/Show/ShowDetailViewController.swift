//
//  ShowDetailViewController.swift
//  TVShowApp
//
//  Created by Jastin on 4/4/22.
//

import Foundation
import UIKit
import DomainLayer

class ShowDetailViewController : UIViewController {
    
    private var showDetailScrollView = UIScrollView()
    private var showDetailContentScrollView = UIView()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont(name: "avenir", size: 30)
        return label
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "avenir", size: 15)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "avenir", size: 17)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var posterImageView: UIImageView = {
        let posterImageView = UIImageView()
        posterImageView.image = .init(systemName: "circle.dashed")
        posterImageView.contentMode = .scaleToFill
        posterImageView.layer.cornerRadius = 30
        posterImageView.clipsToBounds = true
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
            if let rating = showEntity.rating.average {
                if index <= Int(rating) {
                    ratingButtonImage.isSelected = true
                }
            }
            stackView.addArrangedSubview(ratingButtonImage)
        }
        return stackView
    }()
    
    private lazy var genreStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fill
        for index in 0...showEntity.genres.count - 1 {
            let genreLabel = UILabel()
            genreLabel.font = UIFont(name: "avenir", size: 20)
            genreLabel.text = showEntity.genres[index]
            genreLabel.textColor = index % 2 != 0 ? UIColor(named: ColorHelper.red.rawValue) : .white
            stackView.addArrangedSubview(genreLabel)
        }
        return stackView
    }()
    
    
    private lazy var daysStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .fill
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "EEEE"
        let dayInWeek = dateFormatter.string(from: Date.now)
        for index in 0...showEntity.schedule.days.count - 1 {
            let daysLabel = UILabel()
            daysLabel.font = UIFont(name: "avenir", size: 17)
            daysLabel.text = showEntity.schedule.days[index]
            daysLabel.textColor = index % 2 != 0 ? UIColor(named: ColorHelper.red.rawValue) : .white
            stackView.addArrangedSubview(daysLabel)
        }
        return stackView
    }()
    
    private var showEntity: ShowEntity!
    
    init(showEntity: ShowEntity) {
        self.showEntity = showEntity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)
        showDetailContentScrollView.addSubview(self.posterImageView)
        showDetailContentScrollView.addSubview(self.nameLabel)
        showDetailContentScrollView.addSubview(self.ratingStackView)
        showDetailContentScrollView.addSubview(self.genreStackView)
        showDetailContentScrollView.addSubview(self.summaryLabel)
        showDetailContentScrollView.addSubview(self.timeLabel)
        showDetailContentScrollView.addSubview(self.daysStackView)
        showDetailScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 1500)
        showDetailScrollView.addSubview(showDetailContentScrollView)
        self.view.addSubview(showDetailScrollView)
        if let imagedata = showEntity.image?.data {
            self.posterImageView.image = UIImage(data: imagedata)
        }
        self.nameLabel.text = showEntity.name
        self.summaryLabel.text = showEntity.summary
        self.timeLabel.text = showEntity.schedule.time
        
        NSLayoutConstraint.on([self.showDetailScrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
                              self.showDetailScrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor)])
        
        NSLayoutConstraint.on([showDetailContentScrollView.heightAnchor.constraint(equalTo: showDetailScrollView.heightAnchor),
                               showDetailContentScrollView.widthAnchor.constraint(equalTo: showDetailScrollView.widthAnchor)])
        
        
        NSLayoutConstraint.on([self.posterImageView.topAnchor.constraint(equalTo: showDetailContentScrollView.layoutMarginsGuide.topAnchor,constant: 10),
                               self.posterImageView.leftAnchor.constraint(equalTo: showDetailContentScrollView.layoutMarginsGuide.leftAnchor),
                               self.posterImageView.rightAnchor.constraint(equalTo: showDetailContentScrollView.layoutMarginsGuide.rightAnchor),
                               self.posterImageView.heightAnchor.constraint(equalTo: showDetailContentScrollView.heightAnchor,multiplier: 1/2)])
        
        NSLayoutConstraint.on([self.nameLabel.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor,constant: 10),
                               self.nameLabel.centerXAnchor.constraint(equalTo: showDetailContentScrollView.centerXAnchor),
                               self.nameLabel.leftAnchor.constraint(equalTo: self.showDetailContentScrollView.layoutMarginsGuide.leftAnchor),
                               self.nameLabel.rightAnchor.constraint(equalTo: self.showDetailContentScrollView.layoutMarginsGuide.rightAnchor)])
        
        NSLayoutConstraint.on([self.ratingStackView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor,constant: 10),
                               self.ratingStackView.leftAnchor.constraint(equalTo: showDetailContentScrollView.layoutMarginsGuide.leftAnchor),
                               self.ratingStackView.rightAnchor.constraint(equalTo: showDetailContentScrollView.layoutMarginsGuide.rightAnchor)])
        
        NSLayoutConstraint.on([self.genreStackView.topAnchor.constraint(equalTo: self.ratingStackView.bottomAnchor,constant: 10),
                               self.genreStackView.centerXAnchor.constraint(equalTo: showDetailContentScrollView.centerXAnchor)])
        
        NSLayoutConstraint.on([self.summaryLabel.topAnchor.constraint(equalTo: self.genreStackView.bottomAnchor,constant: 10),
                               self.summaryLabel.leftAnchor.constraint(equalTo: showDetailContentScrollView.layoutMarginsGuide.leftAnchor),
                               self.summaryLabel.rightAnchor.constraint(equalTo: showDetailContentScrollView.layoutMarginsGuide.rightAnchor)])
        
        NSLayoutConstraint.on([self.daysStackView.topAnchor.constraint(equalTo: self.summaryLabel.bottomAnchor,constant: 10),
                               self.daysStackView.centerXAnchor.constraint(equalTo: showDetailContentScrollView.centerXAnchor)])
        
        NSLayoutConstraint.on([self.timeLabel.topAnchor.constraint(equalTo: self.daysStackView.bottomAnchor,constant: 10),
                               self.timeLabel.centerXAnchor.constraint(equalTo: showDetailContentScrollView.centerXAnchor)])
        
    }
}

