//
//  addOrEditInspectionViewController.swift
//  RentCar
//
//  Created by Jastin on 22/6/21.
//

import UIKit

class AddOrEditInspectionViewController: UIViewController {
    
    @IBOutlet weak var inspectionVehiclePickerView: UIPickerView!
    @IBOutlet weak var inspectionCustomerPickerView: UIPickerView!
    @IBOutlet weak var InspectionAmountOfCombustibleSegmentControl: UISegmentedControl!
   
    var inspectionPresenter: InspectionPresenter?
    var vehiclePresenter: VehiclePresenter?
    var customerPresenter: CustomerPresenter?
    var employeePresenter: EmployeePresenter?
    
    var inspection: Inspection?
    var vehicleID: UUID?
    var customerID: UUID?
    var combustibleAmount: String!
    var isViewOnly: Bool?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViewDidLoad()
    }
    
    func initViewDidLoad() {
        if let inspection = inspection, let isViewOnly = isViewOnly {
          
            if isViewOnly {
             
                initViewOnly(inspection: inspection, isViewOnly: isViewOnly)
            }
            else {
                initEditOnly(inspection: inspection)
            }
        }
        else {
            initAddOnly()
        }
    }
   
    @IBAction func inspectionAmountOfCombustibleSegmentedControlValueChange(_ sender: Any) {
        self.combustibleAmount = InspectionAmountOfCombustibleSegmentControl.titleForSegment(at: InspectionAmountOfCombustibleSegmentControl.selectedSegmentIndex)!
    }
    
    @IBAction func inspectionNextViewControllerButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: Constant.segue.secondAddOrEditVehicleSegue, sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constant.segue.secondAddOrEditVehicleSegue {
           
            let destinationSecondAddOrEditInspectionViewController  = segue.destination as! SecondAddOrEditInspetionViewController
            
            destinationSecondAddOrEditInspectionViewController.inspectionPresenter = inspectionPresenter
            destinationSecondAddOrEditInspectionViewController.vehicleID = vehicleID
            destinationSecondAddOrEditInspectionViewController.customerID = customerID
            destinationSecondAddOrEditInspectionViewController.combustibleAmount = combustibleAmount
            destinationSecondAddOrEditInspectionViewController.employeePresenter = employeePresenter
            destinationSecondAddOrEditInspectionViewController.isViewOnly = isViewOnly
            destinationSecondAddOrEditInspectionViewController.inspection = inspection
        }
    }
    
    func inspectionModelToOutlets(_ inspection: Inspection) {
        DispatchQueue.main.async {
           
           self.inspectionCustomerPickerView.selectRow(self.customerPresenter!._customers.firstIndex(where: {$0.id == inspection.customer.id})!, inComponent: 0, animated: true)
            
            self.customerID = inspection.customer.id
           
           self.inspectionVehiclePickerView.selectRow(self.vehiclePresenter!._vehicles.firstIndex(where: {$0.id == inspection.vehicle.id})!, inComponent: 0, animated: true)
           
            self.vehicleID = inspection.vehicle.id
            
           let indexAmoutOfCombustible = StringInSegmentedControl().search(inspection.combustibleAmount, segmentedControl: self.InspectionAmountOfCombustibleSegmentControl)
           
           if indexAmoutOfCombustible != -1 {
               self.combustibleAmount = inspection.combustibleAmount
               self.InspectionAmountOfCombustibleSegmentControl.selectedSegmentIndex = indexAmoutOfCombustible
           }
       }
   }
}
