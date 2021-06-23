//
//  InspectionTableViewController.swift
//  RentCar
//
//  Created by Jastin on 22/6/21.
//

import UIKit

class InspectionTableViewController: UITableViewController {
    
    var inspectionPresenter = InspectionPresenter()
    var vehiclePresenter = VehiclePresenter()
    var customerPresenter = CustomerPresenter()
    var employeePresenter = EmployeePresenter()
    var vehiclesJoinInspection = [Vehicle]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        initViewLoad()
        
    }
    
    func initViewLoad() {
        
        vehiclePresenter.getAllWithActiveStatus(){
            self.vehiclePresenter.vehicleViewDelegatePrtocol = self
            self.inspectionPresenter.getAll()
            self.inspectionPresenter.inspectionViewDelagateProtocol = self
        }
        
        employeePresenter.getAllWithActiveStatus()
        customerPresenter.getAllWithActiveStatus{}
        
    }
    
    @IBAction func inspectionAddButtonPressed(_ sender: Any) {
        
        performSegue(withIdentifier: Constant.segue.addOrEditInspectionSegue, sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constant.segue.addOrEditInspectionSegue {
            
            let destinationAddOrEditInspectionController = segue.destination as! AddOrEditInspectionViewController
            
            destinationAddOrEditInspectionController.inspectionPresenter = inspectionPresenter
            destinationAddOrEditInspectionController.customerPresenter = customerPresenter
            destinationAddOrEditInspectionController.vehiclePresenter = vehiclePresenter
            destinationAddOrEditInspectionController.employeePresenter = employeePresenter
            
            if let inspection = sender {
                destinationAddOrEditInspectionController.inspection = (inspection as! (Inspection,Bool)).0
                destinationAddOrEditInspectionController.isViewOnly = (inspection as! (Inspection,Bool)).1
            }
        }
    }
}
