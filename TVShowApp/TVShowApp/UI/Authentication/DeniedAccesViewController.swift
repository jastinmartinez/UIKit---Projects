//
//  DeniedAccesViewController.swift
//  TVShowApp
//
//  Created by Jastin on 6/4/22.
//

import Foundation
import UIKit
public class DeniedAccessViewController : UIViewController {
    
    private lazy var deniedImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .init(systemName: "lock.icloud.fill")
        imageView.tintColor = UIColor(named: ColorHelper.red.rawValue)
        return imageView
    }()
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setDeniedImageView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.setDeniedAlertController()
        }
    }
    
    fileprivate func setDeniedImageView() {
        self.view.addSubview(self.deniedImage)
        NSLayoutConstraint.on([self.deniedImage.heightAnchor.constraint(equalTo: self.view.heightAnchor),
                               self.deniedImage.widthAnchor.constraint(equalTo: self.view.widthAnchor)])
    }
    
    fileprivate func setDeniedAlertController() {
        let alert = UIAlertController(title: "Authentication Problem", message:"Sorry you can't acces TVShow App", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
    }
}
