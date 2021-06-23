//
//  AddOrEditInspectionViewController+AddOnly.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import Foundation
extension AddOrEditInspectionViewController {
    
    func initAddOnly() {
        
        self.inspectionCustomerPickerView.reloadAllComponents()
        
        if inspectionCustomerPickerView.numberOfComponents > 0 {
            
            self.customerID = customerPresenter?.customers.first?.id
        }
        
        self.inspectionVehiclePickerView.reloadAllComponents()
        
        if inspectionVehiclePickerView.numberOfComponents > 0 {
        
            self.vehicleID = vehiclePresenter?.vehicles.first?.id
        }
        
        self.combustibleAmount = InspectionAmountOfCombustibleSegmentControl.titleForSegment(at: 0)!
    }
}
