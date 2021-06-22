//
//  EnableAndDisableValidation.swift
//  RentCar
//
//  Created by Jastin on 19/6/21.
//

import Foundation
import UIKit

final class EnableOutlets {
    
    func label(label: UILabel,message: String = "",setHidden: Bool = false) {
        label.isHidden = setHidden
        label.text = message
    }
    
    func textField(textfield: UITextField) {
        textfield.isEnabled = false
    }
    
    func pickerView(pickerView: UIPickerView) {
        pickerView.isUserInteractionEnabled = false
    }
    
    func button(button: UIBarItem) {
        
        if button is UIBarButtonItem {
            (button as! UIBarButtonItem).isEnabled = false
        }
    }
    
    func switchs(switchs: UISwitch) {
        switchs.isEnabled = false
    }
}
