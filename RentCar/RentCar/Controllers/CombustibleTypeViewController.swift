//
//  CombustibleTypeViewController.swift
//  RentCar
//
//  Created by Jastin on 24/5/21.
//

import UIKit

class CombustibleTypeViewController: UIViewController {
    
    private var combustibleTypePresenter: CombustibleTypePresenter!
    
    override func viewDidLoad() {
        combustibleTypePresenter = CombustibleTypePresenter(service: CombustibleTypeService())
        super.viewDidLoad()
    }
    
    @IBAction func addCombustibleTypePressed(_ sender: Any) {
        var combustibleDescriptionTextField = UITextField()
        let alert = UIAlertController(title: "Tipo Combustible", message: "Nuevo", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Ok", style: .default, handler: { action in
            self.combustibleTypePresenter.create(vm: CombustibleType(description: combustibleDescriptionTextField.text!, state: true))
        })
        saveAction.isEnabled = false
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default))
        alert.addTextField { (text) in
            combustibleDescriptionTextField = text
            combustibleDescriptionTextField.placeholder = "Descripcion"
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: combustibleDescriptionTextField, queue: OperationQueue.main) { (notification) in
                combustibleDescriptionTextField.text  = combustibleDescriptionTextField.text?.trimmingCharacters(in: .whitespaces)
                saveAction.isEnabled = combustibleDescriptionTextField.text!.count >= 2
            }
        }
        present(alert, animated: true, completion: nil)
    }
}
