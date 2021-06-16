//
//  HomeCollectionViewCell.swift
//  RentCar
//
//  Created by Jastin on 6/6/21.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell,BindOutletsProtocol {
    
    typealias aType = Home
    
    @IBOutlet weak var homeImageImage: UIImageView!
    
    func bindDataToOulets(vm: Home) {
        self.homeImageImage.image = UIImage(named: vm.image)
    }
}
