//
//  AlertView.swift
//  RentCar
//
//  Created by Jastin on 23/5/21.
//

import UIKit

final class AlertView {

    func show(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        return alert
    }
    
    func newItem(parameter: AddNewItemViewParameters,create:@escaping(String)->()) -> UIViewController {
        var textField = UITextField()
        let alert = UIAlertController(title: parameter.title, message: parameter.message, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Ok", style: .default, handler: { action in
            create(textField.text!)
        })
        saveAction.isEnabled = false
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .default))
        alert.addTextField { (text) in
            textField = text
            textField.placeholder = parameter.placeholder
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main) { (notification) in
                textField.text  = textField.text?.trimmingCharacters(in: .whitespaces)
                saveAction.isEnabled = textField.text!.count >= 2
            }
        }
        return alert
    }
}
