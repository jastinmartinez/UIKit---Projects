//
//  AddOrEditVehicleViewController+View.swift
//  RentCar
//
//  Created by Jastin on 20/6/21.
//

import Foundation



extension AddOrEditVehicleViewController: MaintenanceViewDelegateProtocol {
    
    func didArrayChange() {
        
        DispatchQueue.main.async { [self] in
            
            self.vehicleVehicleTypePickerView.reloadAllComponents()
            
            self.vehicleVehicleMarkPickerView.reloadAllComponents()
            
            self.vehicleCombustibleTypePickerView.reloadAllComponents()
            
            self.vehicleVehicleModelPickerView.reloadAllComponents()
            
            if vehicleMarkPresenter.vehicleMarks.count > 0 {
                
                if let vehicle = vehicle {
                    
                    if vehicleModelDataIsSet == false {
                        
                        if vehicleModelPresenter.vehicleModelsOfMark.count > 0 {
                            
                            vehicleModelDataIsSet = true
                            
                            vehicleModelPresenter.getModelsOfMarks(vehicleMarkPresenter.vehicleMarks.first(where: {$0.id == vehicle.vehicleMark.id})!)
                            
                            if vehicleModelPresenter.vehicleModels.count > 0 {
                                
                                if vehicleModelID == nil {
                                    
                                    DispatchQueue.main.async {
                                        
                                        if let index = vehicleModelPresenter.vehicleModels.firstIndex(where: {$0.id == vehicle.vehicleModel.id}) {
                                            vehicleVehicleModelPickerView.selectRow(index, inComponent: 0, animated: true)
                                        }

                                    }
                                    
                                    self.vehicleModelID = vehicle.vehicleModel.id
                                }
                            }
                        }
                        
                    }
                    
                }
                
                if vehicleVehicleMarkPickerView.numberOfComponents > 0 {
                    
                    if let vehicle = vehicle {
                        
                        if vehicleMarkID == nil {
                            
                            vehicleVehicleMarkPickerView.selectRow(vehicleMarkPresenter.vehicleMarks.firstIndex(where: {$0.id == vehicle.vehicleMark.id})!, inComponent: 0, animated: true)
                            
                            self.vehicleMarkID = vehicle.vehicleMark.id
                        }
                        
                    }
                    
                    else {
                        
                        self.vehicleMarkID =  self.vehicleMarkPresenter.vehicleMarks[0].id
                        
                        if vehicleModelDataIsSet == false {
                            
                            vehicleModelDataIsSet = true
                            
                            vehicleModelPresenter.getModelsOfMarks(vehicleMarkPresenter.vehicleMarks[0])
                            
                            if vehicleModelPresenter.vehicleModels.count > 0 {
                                
                                self.vehicleModelID = vehicleModelPresenter.vehicleModels[0].id
                                
                                vehicleVehicleModelPickerView.selectRow(0, inComponent: 0, animated: true)
                            }
                        }
                    }
                }
            }

            
            if vehicleTypePresenter.vehicleTypes.count > 0 {
                
                if vehicleVehicleTypePickerView.numberOfComponents > 0 {
                    
                    if let vehicle = vehicle {
                        
                        if vehicleTypeID == nil {
                            
                            self.vehicleTypeID = vehicle.vehicleType.id
                            
                            vehicleVehicleTypePickerView.selectRow(vehicleTypePresenter.vehicleTypes.firstIndex(where: {$0.id == vehicle.vehicleType.id})!, inComponent: 0, animated: true)
                        }
                    }
                    else {
                        
                        self.vehicleTypeID = vehicleTypePresenter.vehicleTypes[0].id
                    }
                }
                
            }
            
            if combustibleTypePresenter.combustibleTypes.count > 0 {
                
                if vehicleCombustibleTypePickerView.numberOfComponents > 0 {
                    
                    if let vehicle = vehicle {
                        
                        if self.combustibleTypeID == nil {
                            
                            self.combustibleTypeID = vehicle.combustibleType.id
                            
                            vehicleCombustibleTypePickerView.selectRow(combustibleTypePresenter.combustibleTypes.firstIndex(where: {$0.id == vehicle.combustibleType.id})!, inComponent: 0, animated: true)
                        }
                    }
                    else {
                        
                        self.combustibleTypeID = combustibleTypePresenter.combustibleTypes[0].id
                    }
                }
            }
        }
    }
}
