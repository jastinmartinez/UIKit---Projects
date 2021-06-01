//
//  AuthenticationViewDelegate.swift
//  RentCar
//
//  Created by Jastin on 30/5/21.
//

import Foundation

protocol AuthenticationViewDelegate: AnyObject {
    func didUserAuthenticated(isUserAuthenticated: Bool)
    func didErrorOcurred(error: Error)
}
