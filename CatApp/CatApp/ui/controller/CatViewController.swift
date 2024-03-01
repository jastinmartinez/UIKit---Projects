//
//  CatViewController.swift
//  CatApp
//
//  Created by Jastin on 1/3/24.
//

import Foundation
import UIKit

public final class CatViewController: UIViewController {
    
    private let cat: Cat
    private lazy var catImageView = makeCatImageView()
    private lazy var catTagsCollectionView = makeCatTagsCollectionView()
    
    private var tags: [String] {
        return cat.tags ?? []
    }
    
    public init(cat: Cat) {
        self.cat = cat
        super.init(nibName: nil, bundle: nil)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        onCreate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func onCreate() {
        setViewStyle()
        setCatImageView()
        makeCatTagHeader()
    }
    
    private func setViewStyle() {
        title = "Profile"
        view.backgroundColor = UIColor.systemBackground
    }
    
    private func setCatImageView() {
        if let image = cat.image {
            catImageView.image = UIImage(data: image)
        } else {
            catImageView.image = UIImage(named: AssetConstant.catNotFound.rawValue)
        }
    }
    
    private func makeCatImageView() -> UIImageView {
        let catImageView = UIImageView()
        catImageView.contentMode = .scaleAspectFill
        catImageView.translatesAutoresizingMaskIntoConstraints = false
        catImageView.layer.borderWidth = 2
        catImageView.layer.borderColor = UIColor.systemGray.cgColor
        catImageView.layer.cornerRadius = 10
        catImageView.layer.masksToBounds = true
        view.addSubview(catImageView)
        NSLayoutConstraint.activate([catImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
                                     catImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     catImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
                                     catImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)])
        return catImageView
    }
    
    private func makeCatTagsCollectionView() -> UICollectionView {
        let tagCollectionViewFlowLayout = UICollectionViewFlowLayout()
        tagCollectionViewFlowLayout.minimumInteritemSpacing = 5
        tagCollectionViewFlowLayout.estimatedItemSize = CGSize(width: 100, height: 50)
        tagCollectionViewFlowLayout.scrollDirection = .horizontal
        
        let tagCollectionView = UICollectionView(frame: .zero, collectionViewLayout: tagCollectionViewFlowLayout)
        tagCollectionView.register(CatTagCollectionViewCell.self, forCellWithReuseIdentifier: CatTagCollectionViewCell.name)
        tagCollectionView.translatesAutoresizingMaskIntoConstraints = false
        tagCollectionView.showsHorizontalScrollIndicator = false
        tagCollectionView.dataSource = self
        view.addSubview(tagCollectionView)
        NSLayoutConstraint.activate([tagCollectionView.topAnchor.constraint(equalTo: catImageView.bottomAnchor, constant: 50),
                                     tagCollectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
                                     tagCollectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     tagCollectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)])
        return tagCollectionView
    }
    
    private func makeCatTagHeader()  {
        let tagHeader = UILabel()
        tagHeader.text = String(AttributedString(
            localized:"^[\(tags.count) \("tag")](inflect: true)").characters)
        tagHeader.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tagHeader)
        NSLayoutConstraint.activate([tagHeader.leadingAnchor.constraint(equalTo: catTagsCollectionView.leadingAnchor),
                                     tagHeader.bottomAnchor.constraint(equalTo: catTagsCollectionView.topAnchor)])
    }
}

extension CatViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let catTagCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath) as CatTagCollectionViewCell
        catTagCollectionViewCell.setTag(tags[indexPath.row])
        return catTagCollectionViewCell
    }
}

#Preview {
    let cat = Cat(id: "Id", size: 2829, tags: ["cute", "ugly", "player", "dummy"])
    let catViewController = CatViewController(cat: cat)
    return catViewController
}
