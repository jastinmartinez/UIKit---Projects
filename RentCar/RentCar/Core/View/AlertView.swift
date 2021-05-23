//
//  AlertView.swift
//  RentCar
//
//  Created by Jastin on 23/5/21.
//

import UIKit

final class AlertView {

    func show(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Autenticacion", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        return alert
    }
}
