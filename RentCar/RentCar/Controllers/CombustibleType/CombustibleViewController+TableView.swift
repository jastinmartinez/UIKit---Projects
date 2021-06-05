//
//  AddCombustibleViewController+TableView.swift
//  RentCar
//
//  Created by Jastin on 31/5/21.
//

import Foundation
import UIKit

extension CombustibleTypeViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return combustibleTypePresenter.combustibleTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.tableViewCell.combustibleTypeTableViewCell) as! CombustibleTypeTableViewCell
        cell.bindDataToOulets(vm: combustibleTypePresenter.combustibleTypes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            combustibleTypePresenter.remove(for: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: Constant.segue.modifyCombustibleTypeSegue, sender: combustibleTypePresenter.combustibleTypes[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segue.modifyCombustibleTypeSegue {
            let destionation = segue.destination as! ModifyCombustibleTypeViewController
            destionation.combustibleType = sender as? CombustibleType
        }
    }
}
