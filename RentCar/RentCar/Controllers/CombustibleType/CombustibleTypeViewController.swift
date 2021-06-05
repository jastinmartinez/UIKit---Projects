//
//  CombustibleTypeViewController.swift
//  RentCar
//
//  Created by Jastin on 24/5/21.
//

import UIKit

class CombustibleTypeViewController: UIViewController {
  
    @IBOutlet weak var combustibleTypeTableView: UITableView!
    
    var combustibleTypePresenter: CombustibleTypePresenter!

    override func viewDidLoad() {
        combustibleTypePresenter = CombustibleTypePresenter(service: CombustibleTypeService())
        self.combustibleTypeTableView.dataSource = self
        self.combustibleTypeTableView.delegate = self
        self.combustibleTypePresenter.combustibleTypeViewDelegate = self
        self.combustibleTypePresenter.getAll()
        super.viewDidLoad()
    }
    
    @IBAction func addCombustibleTypePressed(_ sender: Any) {
        let alert = AlertView().newItem(parameter: AddNewItemViewParameters(title: "Tipo Combustible", message: "Nuevo", placeholder: "Descripcion")) { value in
            self.combustibleTypePresenter.create(vm: CombustibleType( description: value, state: true))
        }
        present(alert, animated: true, completion: nil)
    }
}
