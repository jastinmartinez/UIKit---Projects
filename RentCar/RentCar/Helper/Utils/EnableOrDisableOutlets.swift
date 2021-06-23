//
//  EnableAndDisableValidation.swift
//  RentCar
//
//  Created by Jastin on 19/6/21.
//

import Foundation
import UIKit

final class EnableOrDisableOutlets {
    
    func label(label: UILabel,message: String = "",setHidden: Bool = false) {
        label.isHidden = setHidden
        label.text = message
    }
    
    func textField(textfield: UITextField) {
        textfield.isEnabled = false
    }
    
    func datePicker(datePicker: UIDatePicker) {
        datePicker.isEnabled = false
    }
    
    func segmentedControl(segmentControl: UISegmentedControl) {
        segmentControl.isEnabled = false
    }
    
    func pickerView(pickerView: UIPickerView) {
        pickerView.isUserInteractionEnabled = false
    }
    
    func button(button: UIBarItem) {
        
        if button is UIBarButtonItem {
            (button as! UIBarButtonItem).isEnabled = false
        }
    }
    
    func switchs(switchs: UISwitch, isEnabled: Bool = true, isHidden:Bool = false) {
        switchs.isHidden = isHidden
        switchs.isEnabled = isEnabled
    }
}
