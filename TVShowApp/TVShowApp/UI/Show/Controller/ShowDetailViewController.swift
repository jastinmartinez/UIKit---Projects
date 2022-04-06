//
//  ShowDetailViewController.swift
//  TVShowApp
//
//  Created by Jastin on 4/4/22.
//

import Foundation
import UIKit
import DomainLayer
import PresentationLayer

class ShowDetailViewController : UIViewController {
    
    private var showDetailScrollView = UIScrollView()
    private var showDetailContentScrollView = UIView()
    private lazy var nameLabel: UILabel = UILabel.buildLabelWith(size: 30,color: .white, isMultiline: true,textAligment: .center)
    private lazy var summaryLabel: UILabel = UILabel.buildLabelWith(size: 15,color: .white, isMultiline: true,textAligment: .center)
    private lazy var timeLabel: UILabel = UILabel.buildLabelWith(size: 17,color: .white, isMultiline: true)
    
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
        if showEntity.genres.isEmpty {
            let genreLabel = UILabel.buildLabelWith(size: 20,color: UIColor(named: ColorHelper.red.rawValue)!)
            genreLabel.text = NameHelper.NotAvailable.rawValue
            stackView.addArrangedSubview(genreLabel)
        }
        for index in 0...showEntity.genres.count - 1 {
            let genreLabel = UILabel.buildLabelWith(size: 20,color: index % 2 != 0 ? UIColor(named: ColorHelper.red.rawValue)! : .white)
            genreLabel.text = showEntity.genres[index]
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
        if showEntity.schedule.days.isEmpty {
            let daysLabel = UILabel.buildLabelWith(size: 17,color: UIColor(named: ColorHelper.red.rawValue)!)
            daysLabel.text = NameHelper.NotAvailable.rawValue
            stackView.addArrangedSubview(daysLabel)
        }
        else {
            for index in 0...showEntity.schedule.days.count - 1 {
                let daysLabel = UILabel.buildLabelWith(size: 17,color: index % 2 != 0 ? UIColor(named: ColorHelper.red.rawValue)! : .white)
                daysLabel.text = showEntity.schedule.days[index]
                stackView.addArrangedSubview(daysLabel)
            }
        }
        return stackView
    }()
    
    private lazy var showEpisodeTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NameHelper.cell.rawValue)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.layer.cornerRadius = 30
        tableView.clipsToBounds = true
        tableView.backgroundColor = UIColor(named: ColorHelper.red.rawValue)
        return tableView
    }()
    
    private var showEntity: ShowEntity!
    private var showEpisodeEntityListGropBySeason: [Int:[ShowEpisodeEntity]] = [:]
    private let scrollViewContentHeight = 1500 as CGFloat
    
    required init(showEntity: ShowEntity,showEpisodeEntityListGropBySeason: [Int:[ShowEpisodeEntity]]) {
        self.showEntity = showEntity
        self.showEpisodeEntityListGropBySeason = showEpisodeEntityListGropBySeason
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewConfiguration()
        self.setOutletToSubView()
        self.setShowDetailScrollViewContentSize()
        self.setPosterImageView()
        self.setNameLabel()
        self.setSummaryLabel()
        self.setTimeLabel()
        self.setShowDetailScrollViewConstraint()
        self.setShowDetailContentScrollViewConstraint()
        self.setRatingStackViewConstraint()
        self.setGenreStackViewConstraint()
        self.setDayStackViewConstraint()
        self.setShowEpisodeTableViewConstraint()
        self.updateTableView()
    }
  
    fileprivate func setViewConfiguration() {
        self.view.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)
    }
    
    fileprivate func setOutletToSubView() {
        self.showDetailScrollView.addSubview(self.showDetailContentScrollView)
        self.showDetailContentScrollView.addSubview(self.nameLabel)
        self.showDetailContentScrollView.addSubview(self.ratingStackView)
        self.showDetailContentScrollView.addSubview(self.genreStackView)
        self.showDetailContentScrollView.addSubview(self.summaryLabel)
        self.showDetailContentScrollView.addSubview(self.timeLabel)
        self.showDetailContentScrollView.addSubview(self.daysStackView)
        self.showDetailContentScrollView.addSubview(self.posterImageView)
        self.showDetailContentScrollView.addSubview(self.showEpisodeTableView)
        self.view.addSubview(self.showDetailScrollView)
    }
    
    fileprivate func setShowDetailScrollViewContentSize() {
        self.showDetailScrollView.contentSize = CGSize(width: self.view.frame.size.width, height: scrollViewContentHeight)
    }
    
    fileprivate func setShowEpisodeTableViewConstraint() {
        NSLayoutConstraint.on([self.showEpisodeTableView.topAnchor.constraint(equalTo: self.genreStackView.bottomAnchor,constant: 10),
                               self.showEpisodeTableView.leftAnchor.constraint(equalTo: self.showDetailContentScrollView.layoutMarginsGuide.leftAnchor),
                               self.showEpisodeTableView.rightAnchor.constraint(equalTo: self.showDetailContentScrollView.layoutMarginsGuide.rightAnchor),
                               self.showEpisodeTableView.heightAnchor.constraint(equalToConstant: 350)])
    }
    
    fileprivate func setPosterImageView() {
        if let imagedata = showEntity.image?.data {
            self.posterImageView.image = UIImage(data: imagedata)
        }
        NSLayoutConstraint.on([self.posterImageView.topAnchor.constraint(equalTo: self.showDetailContentScrollView.layoutMarginsGuide.topAnchor,constant: 10),
                               self.posterImageView.leftAnchor.constraint(equalTo: self.showDetailContentScrollView.layoutMarginsGuide.leftAnchor),
                               self.posterImageView.rightAnchor.constraint(equalTo: self.showDetailContentScrollView.layoutMarginsGuide.rightAnchor),
                               self.posterImageView.heightAnchor.constraint(equalTo: self.showDetailContentScrollView.heightAnchor,multiplier: 1/2)])
    }
    
    fileprivate func setNameLabel() {
        self.nameLabel.text = showEntity.name
        NSLayoutConstraint.on([self.nameLabel.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor,constant: 10),
                               self.nameLabel.centerXAnchor.constraint(equalTo: self.showDetailContentScrollView.centerXAnchor),
                               self.nameLabel.leftAnchor.constraint(equalTo: self.showDetailContentScrollView.layoutMarginsGuide.leftAnchor),
                               self.nameLabel.rightAnchor.constraint(equalTo: self.showDetailContentScrollView.layoutMarginsGuide.rightAnchor)])
    }
    
    fileprivate func setSummaryLabel() {
        self.summaryLabel.text = showEntity.summary
        NSLayoutConstraint.on([self.summaryLabel.topAnchor.constraint(equalTo: self.showEpisodeTableView.bottomAnchor,constant: 10),
                               self.summaryLabel.leftAnchor.constraint(equalTo: self.showDetailContentScrollView.layoutMarginsGuide.leftAnchor),
                               self.summaryLabel.rightAnchor.constraint(equalTo: self.showDetailContentScrollView.layoutMarginsGuide.rightAnchor)])
    }
    
    fileprivate func setTimeLabel() {
        self.timeLabel.text = showEntity.schedule.time.isEmpty ? NameHelper.NotAvailable.rawValue : showEntity.schedule.time
        NSLayoutConstraint.on([self.timeLabel.topAnchor.constraint(equalTo: self.daysStackView.bottomAnchor,constant: 10),
                               self.timeLabel.centerXAnchor.constraint(equalTo: self.showDetailContentScrollView.centerXAnchor)])
    }
    
    fileprivate func setShowDetailScrollViewConstraint() {
        NSLayoutConstraint.on([self.showDetailScrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
                               self.showDetailScrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor)])
    }
    
    fileprivate func setShowDetailContentScrollViewConstraint() {
        NSLayoutConstraint.on([self.showDetailContentScrollView.heightAnchor.constraint(equalTo: self.showDetailScrollView.heightAnchor),
                               self.showDetailContentScrollView.widthAnchor.constraint(equalTo: self.showDetailScrollView.widthAnchor)])
    }
    
    fileprivate func setRatingStackViewConstraint() {
        NSLayoutConstraint.on([self.ratingStackView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor,constant: 10),
                               self.ratingStackView.leftAnchor.constraint(equalTo: self.showDetailContentScrollView.layoutMarginsGuide.leftAnchor),
                               self.ratingStackView.rightAnchor.constraint(equalTo: self.showDetailContentScrollView.layoutMarginsGuide.rightAnchor)])
    }
    
    fileprivate func setGenreStackViewConstraint() {
        NSLayoutConstraint.on([self.genreStackView.topAnchor.constraint(equalTo: self.ratingStackView.bottomAnchor,constant: 10),
                               self.genreStackView.centerXAnchor.constraint(equalTo: self.showDetailContentScrollView.centerXAnchor)])
    }
    
    fileprivate func setDayStackViewConstraint() {
        NSLayoutConstraint.on([self.daysStackView.topAnchor.constraint(equalTo: self.summaryLabel.bottomAnchor,constant: 10),
                               self.daysStackView.centerXAnchor.constraint(equalTo: self.showDetailContentScrollView.centerXAnchor)])
    }
    
    fileprivate func updateTableView() {
        DispatchQueue.main.async {
            self.showEpisodeTableView.reloadData()
        }
    }
}

extension ShowDetailViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.showEpisodeEntityListGropBySeason.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showEpisodeEntityListGropBySeason[section]?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let showEpisodeTableViewCell = tableView.dequeueReusableCell(withIdentifier: NameHelper.cell.rawValue, for: indexPath) as UITableViewCell
        var cellConfiguration = UIListContentConfiguration.cell()
        if let showEntityList = self.showEpisodeEntityListGropBySeason[indexPath.section] {
            cellConfiguration.text = "\(showEntityList[indexPath.row].number)"
            showEpisodeTableViewCell.accessoryType = .disclosureIndicator
        }
        else {
            cellConfiguration.text = NameHelper.NotAvailable.rawValue
        }
        showEpisodeTableViewCell.contentConfiguration = cellConfiguration
        showEpisodeTableViewCell.backgroundColor = UIColor(named: ColorHelper.blue.rawValue)
        showEpisodeTableViewCell.selectionStyle = .none
        return showEpisodeTableViewCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Season" : "Season \(section)"
    }
}

extension ShowDetailViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
}

