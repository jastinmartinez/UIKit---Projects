//
//  ManagementViewController.swift
//  RentCar
//
//  Created by Jastin on 30/5/21.
//

import UIKit

class ManagementViewController: UIViewController {

    @IBOutlet weak var managementCollectionVIew: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.managementCollectionVIew.dataSource = self
        self.managementCollectionVIew.delegate = self
    }
    
    @IBAction func CloseSessionButtonPressed(_ sender: Any) {
        UserDefaultsDbHelper().removeUser()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let manegementViewController = storyBoard.instantiateViewController(withIdentifier: Constant.storyBoardId.authenticationViewController) as? AuthenticationViewController
        {
            view.window?.rootViewController = manegementViewController
            view.window?.makeKeyAndVisible()
        }
    }
}
