//
//  ConfigurationTableViewCell.swift
//  TVShowApp
//
//  Created by Jastin on 6/4/22.
//

import UIKit
import LocalAuthentication

class ConfigurationTableViewCell : UITableViewCell {
    private lazy var configurationTitleLabel = UILabel.buildLabelWith(size: 15,color: .white)
    private lazy var configurationImage: UIImageView = {
        let uiImageView = UIImageView()
        uiImageView.image = .init(systemName: "circle.dashed")
        uiImageView.contentMode = .scaleAspectFit
        return uiImageView
    }()
    private var configurationSwitch = UISwitch()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setViewConfiguration()
        self.addOutletToSubView()
        self.setConfigurationTitleConstraint()
        self.setConfigurationImageConstraint()
        self.setConfigurationSwitchConstraint()
    }
    
    fileprivate func setViewConfiguration() {
        self.backgroundColor = UIColor(named: ColorHelper.red.rawValue)
        self.tintColor = UIColor(named: ColorHelper.white.rawValue)
    }
    
    fileprivate func addOutletToSubView() {
        self.addSubview(self.configurationTitleLabel)
        self.addSubview(self.configurationImage)
        self.addSubview(self.configurationSwitch)
    }
    
    fileprivate func setConfigurationTitleConstraint() {
        NSLayoutConstraint.on([self.configurationTitleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                               self.configurationTitleLabel.leftAnchor.constraint(equalTo: self.configurationImage.rightAnchor,constant: 10)])
    }
    
    fileprivate func setConfigurationImageConstraint() {
        NSLayoutConstraint.on([self.configurationImage.leftAnchor.constraint(equalTo: self.layoutMarginsGuide.leftAnchor),
                               self.configurationImage.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
    }
    
    fileprivate func setConfigurationSwitchConstraint() {
        let isOn = UserDefaults.standard.object(forKey: NameHelper.auth.rawValue) as? Bool
        self.configurationSwitch.setOn(isOn ?? false, animated: true)
        self.configurationSwitch.addTarget(self, action: #selector(togleValueChanged), for: .valueChanged)
        NSLayoutConstraint.on([self.configurationSwitch.rightAnchor.constraint(equalTo: self.layoutMarginsGuide.rightAnchor),
                               self.configurationSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor)])
    }
    
    fileprivate func saveSwitchState(state: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(state, forKey: NameHelper.auth.rawValue)
        userDefaults.synchronize()
    }
    
    @objc fileprivate func togleValueChanged(sender: UISwitch) {
        if sender.isOn {
            BiometricalAuthentication.verify { isValid in
                if !isValid {
                    DispatchQueue.main.async {
                        self.configurationSwitch.setOn(false, animated: true)
                    }
                } else {
                    self.saveSwitchState(state: true)
                }
            }
        } else {
            self.saveSwitchState(state: false)
        }
    }
    
    func setConfiguration(name: String, image: UIImage?) {
        self.configurationTitleLabel.text = name
        self.configurationImage.image = image
    }
}
