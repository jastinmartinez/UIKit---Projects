//
//  HomeViewController+CollectionView.swift
//  RentCar
//
//  Created by Jastin on 6/6/21.
//

import Foundation
import UIKit

extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Home.homeCollectionImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.reusableView.homeCollectionReusableView, for: indexPath) as! HomeCollectionViewCell
        cell.bindDataToOulets(vm: Home.homeCollectionImages[indexPath.row])
        return cell
    }
}
