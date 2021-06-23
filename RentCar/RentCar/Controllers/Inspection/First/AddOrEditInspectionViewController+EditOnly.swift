//
//  AddOrEditInspectionViewController+EditOnly.swift
//  RentCar
//
//  Created by Jastin on 23/6/21.
//

import Foundation

extension AddOrEditInspectionViewController {
    
    func initEditOnly(inspection:Inspection) {
        
        self.title = "Editar"
        inspectionModelToOutlets(inspection)
    }
}
