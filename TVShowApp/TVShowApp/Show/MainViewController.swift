//
//  MainViewController.swift
//  TVShowApp
//
//  Created by Jastin on 1/4/22.
//

import UIKit
import PresentationLayer
import RxSwift
import RxCocoa

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setConfiguration()
    }
    fileprivate func setConfiguration() {
        
        let showViewModel = ShowDependencyInjection().setShowViewModelDependecy()
        let showViewController = ShowViewController(showViewModel: showViewModel)
        self.setViewControllers([ showViewController,ConfigurationViewController()], animated: true)
        self.tabBar.backgroundColor = .systemBlue
    }
}


class ShowViewController : UIViewController, UIScrollViewDelegate {

    private let disposableBag = DisposeBag()
    private var showViewModel: ShowViewModel!
    private lazy var showCollectionView: UICollectionView = {
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.itemSize = CGSize(width: 100, height: 100)
        collectionViewFlowLayout.minimumLineSpacing = 1
        collectionViewFlowLayout.minimumInteritemSpacing = 1
        collectionViewFlowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.register(ShowCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    init(showViewModel: ShowViewModel) {
        self.showViewModel = showViewModel
        self.showViewModel.fetchShowList()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tabBarItem = UITabBarItem(title: "Movie", image: UIImage(systemName: "ticket"), tag: 0)

        self.showViewModel.showEntityList.bind(to: self.showCollectionView.rx.items(cellIdentifier: "cell",cellType: ShowCollectionViewCell.self)) { _, showEntity, cell in cell.setTitleLabel(text: showEntity.name) }.disposed(by: disposableBag)
        self.view.addSubview(self.showCollectionView)
        NSLayoutConstraint.on([self.showCollectionView.heightAnchor.constraint(equalTo: self.view.heightAnchor),
                               self.showCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor)])
    }
}

class ShowCollectionViewCell : UICollectionViewCell {
    
    private var titleLabel = UILabel()
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.numberOfLines = 0
        self.titleLabel.textAlignment = .left
        self.addSubview(titleLabel)
        NSLayoutConstraint.on([self.titleLabel.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor),
                               self.titleLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
                               self.titleLabel.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor)])
    }
    
    func setTitleLabel(text: String?) {
        self.titleLabel.text = text
    }
}

class ConfigurationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tabBarItem = UITabBarItem(title: "Configuration", image: UIImage(systemName: "gear.circle"), tag: 0)
    }
}

extension NSLayoutConstraint {
    class func on(_ constraints:[NSLayoutConstraint]) {
        for constraint in constraints {
            (constraint.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
            constraint.isActive = true
        }
    }
}

