//
//  ViewController.swift
//  RentCar
//
//  Created by Jastin on 14/5/21.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var tokenLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayUserInfo()
    }
    func displayUserInfo () {
         DbHelper().getUser { user in
            idLabel.text = user.id.uuidString
            nameLabel.text = user.name
            emailLabel.text = user.email
            tokenLabel.text = user.token
        }
    }
    @IBAction func logOutPressed(_ sender: Any) {
        DbHelper().setUserLoggedIn(bool: false)
        DbHelper().removeUser()
    
    }
}

