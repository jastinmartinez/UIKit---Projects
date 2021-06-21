//
//  VehicleTableViewController.swift
//  RentCar
//
//  Created by Jastin on 20/6/21.
//

import UIKit

class VehicleCollectionView: UICollectionViewController {
    
    var vehiclePresenter = VehiclePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewDidLoad()
    }
    
    func initViewDidLoad() {
        vehiclePresenter.getAll()
        vehiclePresenter.vehicleViewDelegatePrtocol = self
    }
    
    @IBAction func addOrEditVehicleButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: Constant.segue.addOrEditVehicleSegue, sender: nil)
    }
}
