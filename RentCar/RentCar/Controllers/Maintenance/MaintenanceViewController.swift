//
//  CombustibleTypeViewController.swift
//  RentCar
//
//  Created by Jastin on 24/5/21.
//

import UIKit

class MaintenanceViewController: UIViewController {
    
    @IBOutlet weak var maintTableView: UITableView!
    
    var presenterType: PresenterTypeProtocol!
    
    override func viewDidLoad() {
        self.maintTableView.dataSource = self
        self.maintTableView.delegate = self
        initServices()
        setViewControllerTitle()
        super.viewDidLoad()
    }
    
    func initServices() {
        if presenterType is CombustibleTypePresenter {
            let combustibletypeService: CombustibleTypePresenter = presenterType as! CombustibleTypePresenter
            combustibletypeService.combustibleTypeViewDelegate = self
            combustibletypeService.getAll()
            
        } else if self.presenterType is VehicleMarkPresenter {
            let vehicleMarkService: VehicleMarkPresenter = presenterType as! VehicleMarkPresenter
            vehicleMarkService.maintenanceViewDelegate = self
            vehicleMarkService.getAll()
        }
    }
    
    @IBAction func addCombustibleTypePressed(_ sender: Any) {
        var alert = UIViewController()
        
        if self.presenterType is CombustibleTypePresenter {
            
            alert = AlertView().newItem(parameter: AddNewItemViewParameters(title: "Tipo Combustible", message: "Nuevo", placeholder: "Descripcion")) { value in
                let combustibleTypePresenter: CombustibleTypePresenter = self.presenterType as! CombustibleTypePresenter
                combustibleTypePresenter.create(vm:CombustibleType(description: value, state: true))
            }
            
        } else if self.presenterType is VehicleMarkPresenter {
            
            alert = AlertView().newItem(parameter: AddNewItemViewParameters(title: "Marca Vehiculo", message: "Nuevo", placeholder: "Descripcion")) { value in
                let vehicleMarkPresenter: VehicleMarkPresenter = self.presenterType as! VehicleMarkPresenter
                vehicleMarkPresenter.create(VehicleMark(description: value, state: true))
            }
        }
        present(alert, animated: true, completion: nil)
    }
}
