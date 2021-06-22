//
//  DbHelper.swift
//  RentCar
//
//  Created by Jastin on 21/5/21.
//

import Foundation

final class UserDefaultsDbHelper {
    
    private let userDefault = UserDefaults.standard
    private var userKey = "user"
    private var userIsLoggedInKey = "userIsLoggedIn"
    
    func saveUser(_ user: User)  {
        let userEncoded = try! JSONEncoder().encode(user)
        userDefault.set(userEncoded ,forKey: userKey)
        setUserLoggedIn()
        userDefault.synchronize()
    }
    
    var getUser: User?  {
        guard let userData = userDefault.data(forKey: userKey) else { return nil }
        let tryUserData = try! JSONDecoder().decode(User.self, from: userData)
        return User(id: tryUserData.id, name: tryUserData.name, email: tryUserData.email, token: tryUserData.token)
    }
    
    func setUserLoggedIn(_ bool: Bool = true) {
        userDefault.set(bool, forKey: userIsLoggedInKey)
        userDefault.synchronize()
    }
    
    func isUserLoggedIn() -> Bool {
        return  userDefault.bool(forKey: userIsLoggedInKey)
    }
    
    func removeUser() {
        userDefault.removeObject(forKey: userKey)
        setUserLoggedIn(false)
        userDefault.synchronize()
    }
}
