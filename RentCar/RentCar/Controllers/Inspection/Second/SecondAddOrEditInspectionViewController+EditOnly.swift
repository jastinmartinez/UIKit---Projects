//
//  SecondAddOrEditInspectionViewController+EditOnly.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import Foundation

extension SecondAddOrEditInspetionViewController {
    
    func initEditOnly(inspection: Inspection) {
        
        self.title = "Editar (2)"
        
        inspectionModelToOutlet(inspection)
    }
}
