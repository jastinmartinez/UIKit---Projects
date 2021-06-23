//
//  RentTableViewController.swift
//  RentCar
//
//  Created by Jastin on 22/6/21.
//

import UIKit

class RentTableViewController: UITableViewController {
    
    var rentPresenter = RentPresenter()
    var employeePresenter = EmployeePresenter()
    var vehiclePresenter = VehiclePresenter()
    var customerPresenter = CustomerPresenter()
    var inspectionPresenter = InspectionPresenter()
    var vehicleJoinRent = [Vehicle]()
    var vehicleJoinInspection = [Vehicle]()
    var customersJoinRent = [Customer]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewDidload()
    }
    
    func initViewDidload() {
        
        DispatchQueue.main.async { [self] in
            
            employeePresenter.getAllWithActiveStatus()
            
            self.customerPresenter.getAllWithActiveStatus {
                self.vehiclePresenter.getAllWithActiveStatus{
                    
                    self.inspectionPresenter.getAllInpectionOfDate{
                    
                        self.rentPresenter.getAll()
                        
                        self.rentPresenter.rentViewDelegateProtocol = self
                    }
                }
            }
        }
    }
    
    @IBAction func rentGoAddOrEditButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: Constant.segue.addOrEditRentSegue, sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constant.segue.addOrEditRentSegue {
            
            let destinationAddOrEditRentViewController = segue.destination as! AddOrEditRentViewController
            
            destinationAddOrEditRentViewController.rentPresenter = rentPresenter
            destinationAddOrEditRentViewController.customerPresenter = customerPresenter
            destinationAddOrEditRentViewController.employeePresenter = employeePresenter
            destinationAddOrEditRentViewController.vehiclePresenter = vehiclePresenter
            
            if let rent = sender {
                
                destinationAddOrEditRentViewController.rent = (rent as! (Rent,Bool)).0
                destinationAddOrEditRentViewController.isViewOnly = (rent as! (Rent,Bool)).1
            }
        }
    }
}
