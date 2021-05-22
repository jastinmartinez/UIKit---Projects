//
//  DbHelper.swift
//  RentCar
//
//  Created by Jastin on 21/5/21.
//

import Foundation

final class DbHelper {
    
    private let userdefault = UserDefaults.standard
    private var userKey:String = "user"
    private var userIsLoggedInKey:String = "userIsLoggedIn"
    
    func saveUser(for dic: Dictionary<String,Any>) {
        userdefault.set(dic,forKey: userKey)
        setUserLoggedIn(bool: true)
    }
    
    func getUser(completion: (User) -> ())  {
        if let dic  = userdefault.dictionary(forKey: userKey)
        {
            if let id = dic["id"] as? UUID, let name = dic["name"] as? String,let email = dic["email"] as? String, let token = dic["token"] as? String
            {
                completion(User(id: id, name: name, email: email, token: token))
            }
        }
    }
    
    func setUserLoggedIn(bool: Bool) {
        
        userdefault.set(bool, forKey: userIsLoggedInKey)
    }
    
    func isUserLoggedIn() -> Bool {
        
        return userdefault.bool(forKey: userIsLoggedInKey)
    }
}
