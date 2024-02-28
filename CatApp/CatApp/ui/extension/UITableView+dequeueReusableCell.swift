//
//  UITableView + DequeueReusable.swift
//  CatApp
//
//  Created by Jastin on 28/2/24.
//

import Foundation
import UIKit

extension UITableView {
    func dequeueReusableCell<T: IdentifiableCell>(for indexPath: IndexPath) -> T {
        guard let cell =  dequeueReusableCell(withIdentifier: T.name, for: indexPath) as? T else {
            fatalError("Not cell registered with name \(T.name))")
        }
        return cell
    }
}
