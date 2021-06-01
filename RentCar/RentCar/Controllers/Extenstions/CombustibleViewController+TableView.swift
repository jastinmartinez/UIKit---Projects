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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "a")!
        return cell
    }
}
