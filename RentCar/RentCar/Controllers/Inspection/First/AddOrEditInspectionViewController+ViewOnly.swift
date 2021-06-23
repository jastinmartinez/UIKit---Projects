//
//  AddOrEditInspectionViewOnly.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import Foundation

extension AddOrEditInspectionViewController {
    
    func initViewOnly(inspection: Inspection, isViewOnly: Bool) {
        
        self.title = "Visualizar"
        EnableOrDisableOutlets().pickerView(pickerView: inspectionCustomerPickerView)
        EnableOrDisableOutlets().pickerView(pickerView: inspectionVehiclePickerView)
        EnableOrDisableOutlets().segmentedControl(segmentControl:  InspectionAmountOfCombustibleSegmentControl)
        
        inspectionModelToOutlets(inspection)
        
    }
}
