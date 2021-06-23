//
//  VehicleTableViewController.swift
//  RentCar
//
//  Created by Jastin on 20/6/21.
//

import UIKit

class VehicleTableViewController: UITableViewController {
    
    var vehiclePresenter = VehiclePresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewDidLoad()
    }
    
    func initViewDidLoad() {
        
        vehiclePresenter.getAll{}
        vehiclePresenter.vehicleViewDelegatePrtocol = self
    }
    
    @IBAction func addOrEditVehicleButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: Constant.segue.addOrEditVehicleSegue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constant.segue.addOrEditVehicleSegue {
            
            let destinationAddOrEditVehicleViewController = segue.destination as? AddOrEditVehicleViewController
            
            destinationAddOrEditVehicleViewController?.vehiclePresenter = vehiclePresenter
            
            if let vehicle = sender {
               
                destinationAddOrEditVehicleViewController?.vehicle = ((vehicle as! (Vehicle,Bool)).0)
                destinationAddOrEditVehicleViewController?.isViewOnly = ((vehicle as! (Vehicle,Bool)).1)
            }
        }
    }
}
