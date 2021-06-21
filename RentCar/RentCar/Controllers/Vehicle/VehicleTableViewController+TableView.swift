//
//  VehicleTableViewController+TableView.swift
//  RentCar
//
//  Created by Jastin on 21/6/21.
//

import Foundation
import UIKit

extension VehicleCollectionView {
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return vehiclePresenter.vehicles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return {
            let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: Constant.reusableView.vehicleReusableView, for: indexPath) as! VehicleCollectionViewCell)
             cell.bindDataToOulets(vm: vehiclePresenter.vehicles[indexPath.row])
             return cell
        }()
    }
}
