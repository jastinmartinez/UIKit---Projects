//
//  AddCombustibleViewController+TableView.swift
//  RentCar
//
//  Created by Jastin on 31/5/21.
//

import Foundation
import UIKit

extension MaintenanceViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if presenterType is CombustibleTypePresenter {
            
            return (presenterType as! CombustibleTypePresenter).combustibleTypes.count
            
        }
        else if presenterType is VehicleMarkPresenter {
            
            return (presenterType as! VehicleMarkPresenter).vehicleMarks.count
            
        }
        else if presenterType is VehicleTypePresenter {
            
            return (presenterType as! VehicleTypePresenter).vehicleTypes.count
        }
        else if presenterType is VehicleModelPresenter {
            
            return (presenterType as! VehicleModelPresenter).vehicleModels.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.tableViewCell.maintenanceTypeTableViewCell) as! MaintenanceTypeTableViewCell
        
        if presenterType is CombustibleTypePresenter {
            
            cell.bindDataToOulets(vm: (presenterType as! CombustibleTypePresenter).combustibleTypes[indexPath.row])
        }
        else if presenterType is VehicleMarkPresenter {
            
            cell.bindDataToOulets(vm: (presenterType as! VehicleMarkPresenter).vehicleMarks[indexPath.row])
        }
        else if presenterType is VehicleTypePresenter {
            
            cell.bindDataToOulets(vm: (presenterType as! VehicleTypePresenter).vehicleTypes[indexPath.row])
        }
        else if presenterType is VehicleModelPresenter {
            
            cell.bindDataToOulets(vm: (presenterType as! VehicleModelPresenter).vehicleModels[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            if presenterType is CombustibleTypePresenter {
                
                (presenterType as! CombustibleTypePresenter).remove(for: indexPath.row)
                
            } else if presenterType is VehicleMarkPresenter {
                
                (presenterType as! VehicleMarkPresenter).remove(for: indexPath.row)
            }
            else if presenterType is VehicleTypePresenter {
                
                (presenterType as! VehicleTypePresenter).remove(for: indexPath.row)
            }
            else if presenterType is VehicleModelPresenter {
                
                (presenterType as! VehicleModelPresenter).remove(for: indexPath.row)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if presenterType is VehicleMarkPresenter {
            
            if ((presenterType as! VehicleMarkPresenter).vehicleMarks[indexPath.row].state) {
                cell.accessoryType = .detailButton
            }
            else {
                cell.accessoryType = .none
            }
        } else {
            
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        if presenterType is VehicleMarkPresenter {
            modelType = (presenterType as! VehicleMarkPresenter).vehicleMarks[indexPath.row]
            presenterType = VehicleModelPresenter()
            self.viewDidLoad()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if presenterType is CombustibleTypePresenter {
            
            performSegue(withIdentifier: Constant.segue.maintenanceModifySegue, sender: (presenterType as! CombustibleTypePresenter).combustibleTypes[indexPath.row])
        }
        
        else if presenterType is VehicleMarkPresenter  {
            
            performSegue(withIdentifier: Constant.segue.maintenanceModifySegue, sender: (presenterType as! VehicleMarkPresenter).vehicleMarks[indexPath.row])
        }
        
        else if presenterType is VehicleTypePresenter  {
            
            performSegue(withIdentifier: Constant.segue.maintenanceModifySegue, sender: (presenterType as! VehicleTypePresenter).vehicleTypes[indexPath.row])
        }
        
        else if presenterType is VehicleModelPresenter  {
            
            performSegue(withIdentifier: Constant.segue.maintenanceModifySegue, sender: (presenterType as! VehicleModelPresenter).vehicleModels[indexPath.row])
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constant.segue.maintenanceModifySegue {
            
            let destionation = segue.destination as! ModifyMaintenanceViewController
            
            if presenterType is CombustibleTypePresenter {
                
                destionation.presenterType = (presenterType as? CombustibleTypePresenter)
                destionation.modelType = (sender as? CombustibleType)
            }
            
            else if presenterType is VehicleMarkPresenter {
                
                destionation.presenterType = (presenterType as? VehicleMarkPresenter)
                destionation.modelType = (sender as? VehicleMark)
            }
            
            else if presenterType is VehicleTypePresenter {
                
                destionation.presenterType = (presenterType as? VehicleTypePresenter)
                destionation.modelType = (sender as? VehicleType)
            }
            
            else if presenterType is VehicleModelPresenter {
                
                destionation.presenterType = (presenterType as? VehicleModelPresenter)
                destionation.modelType = (sender as? VehicleModel)
            }
        }
        
    }
}
