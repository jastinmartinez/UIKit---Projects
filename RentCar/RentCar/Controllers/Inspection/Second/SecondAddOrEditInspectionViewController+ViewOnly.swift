//
//  SecondAddOrEditInspectionViewController+ViewOnly.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import Foundation

extension SecondAddOrEditInspetionViewController {
    
    
    func initViewOnly(inspection: Inspection,isViewOnly:Bool) {
        
        self.title = "Visualizar (2)"
        EnableOrDisableOutlets().switchs(switchs: InspectionStateSwitch,isEnabled: false)
        EnableOrDisableOutlets().switchs(switchs: inspectionScratchSwitch,isEnabled: false)
        EnableOrDisableOutlets().switchs(switchs: inspectionRubber1Switch,isEnabled: false)
        EnableOrDisableOutlets().switchs(switchs: inspectionRubber2Switch,isEnabled: false)
        EnableOrDisableOutlets().switchs(switchs: inspectionRubber3Switch,isEnabled: false)
        EnableOrDisableOutlets().switchs(switchs: inspectionRubber4Switch,isEnabled: false)
        EnableOrDisableOutlets().switchs(switchs: inspectionHydraulicJackSwitch,isEnabled: false)
        EnableOrDisableOutlets().switchs(switchs: inspectionGlassBreakageSwitch,isEnabled: false)
        EnableOrDisableOutlets().pickerView(pickerView: inspectionEmployeePickerView)
        EnableOrDisableOutlets().datePicker(datePicker: inspectionDateDatePicker)
        inspectionModelToOutlet(inspection)
        
    }
}
