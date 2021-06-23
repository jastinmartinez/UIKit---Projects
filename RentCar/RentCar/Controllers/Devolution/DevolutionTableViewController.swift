//
//  DevolutionTableViewController.swift
//  RentCar
//
//  Created by Jastin on 22/6/21.
//

import UIKit

class DevolutionTableViewController: UITableViewController, DevolutionViewDelegateProtocol {
   
    func didDevolutionload() {
        
        for devolution in devolutionPresenter.devolutions {
            
            if let customer = customerPresenter.customers.first(where: {$0.id ==  devolution.customer.id}) {
            
                customers.append(customer)
            }
            
            if let vehicle = vehiclePresenter.vehicles.first(where: {$0.id == devolution.vehicle.id}) {
                
                vehicles.append(vehicle)
            }
        }
        
        self.tableView.reloadData()
    }

    var devolutionPresenter = DevolutionPresenter()
    var customerPresenter = CustomerPresenter()
    var vehiclePresenter = VehiclePresenter()
    
    var vehicles = [Vehicle]()
    var customers = [Customer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.vehiclePresenter.getAll{
                self.customerPresenter.getAll { [self] in
                    self.devolutionPresenter.getAll()
                    self.devolutionPresenter.devolutionViewDelegateProtocol = self
                }
            }
        }
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return devolutionPresenter.devolutions.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.tableViewCell.devolutionTableViewCell) as! DevolutionTableViewCell
     
        cell.bindProperty(vm: (devolutionPresenter.devolutions[indexPath.row].amountOfDay.toString(), customers[indexPath.row].name, vehicles[indexPath.row].description,devolutionPresenter.devolutions[indexPath.row].amountPerDay.ToString() , Int(devolutionPresenter.devolutions[indexPath.row].amountOfDay  * Int.init(devolutionPresenter.devolutions[indexPath.row].amountPerDay)).toString(),devolutionPresenter.devolutions[indexPath.row].date))
        return cell
    }
}
