//
//  ManagementViewController+CollectionView.swift
//  RentCar
//
//  Created by Jastin on 30/5/21.
//

import UIKit
import Foundation

extension ManagementViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return managementMenuData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.reusableView.managementReusableView, for: indexPath) as! ManagementCollectionViewCell
        cell.bindOutlets(vm: managementMenuData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: managementMenuData[indexPath.row].segue, sender: managementMenuData[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segue.maintenanceSegue {
            (segue.destination as! MaintenanceViewController).presenterType = (sender as! Management).presenterType
        }
    }
}
