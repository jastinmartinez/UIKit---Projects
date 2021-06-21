//
//  VehicleTableViewController.swift
//  RentCar
//
//  Created by Jastin on 20/6/21.
//

import UIKit

class VehicleTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewDidLoad()
    }
    
    func initViewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @IBAction func addOrEditVehicleButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: Constant.segue.addOrEditVehicleSegue, sender: nil)
    }
}
