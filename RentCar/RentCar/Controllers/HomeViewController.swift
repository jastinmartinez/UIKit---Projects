//
//  ViewController.swift
//  RentCar
//
//  Created by Jastin on 14/5/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        DbHelper().removeUser()
        DbHelper().setUserLoggedIn( false)
    }
}

