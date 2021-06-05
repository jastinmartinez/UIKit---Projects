//
//  AddNewItemViewParameters.swift
//  RentCar
//
//  Created by Jastin on 5/6/21.
//

import Foundation

class AddNewItemViewParameters {
    
    var title: String = ""
    var message: String = ""
    var placeholder: String = ""
   
    init(title: String,message: String,placeholder: String) {
        self.title = title
        self.message = message
        self.placeholder = placeholder
    }
}
