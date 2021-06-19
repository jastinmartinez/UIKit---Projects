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
    
    var modelType: ModelType!
    
    override func  viewDidLoad() {
        self.maintTableView.dataSource = self
        self.maintTableView.delegate = self
        initServices()
        setViewControllerTitle()
        super.viewDidLoad()
    }
    
    @IBAction func addMaintenancePressed(_ sender: Any) {
       addNew()
    }
}
