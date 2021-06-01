//
//  ManagementCollectionViewCell.swift
//  RentCar
//
//  Created by Jastin on 30/5/21.
//

import UIKit

class ManagementCollectionViewCell: UICollectionViewCell {
   
    @IBOutlet weak var managementNameLabel: UILabel!
    @IBOutlet weak var managementImageImage: UIImageView!
 
    func bindOutlets(vm: Management)  {
        self.managementNameLabel.text = vm.name
        self.managementImageImage.image = UIImage(named: vm.image)
    }
}
