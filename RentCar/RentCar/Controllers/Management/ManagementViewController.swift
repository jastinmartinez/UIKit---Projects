//
//  ManagementViewController.swift
//  RentCar
//
//  Created by Jastin on 30/5/21.
//

import UIKit

class ManagementViewController: UIViewController {

    @IBOutlet weak var managementCollectionVIew: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.managementCollectionVIew.dataSource = self
        self.managementCollectionVIew.delegate = self
    }
}
