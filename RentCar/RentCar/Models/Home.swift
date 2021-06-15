//
//  Home.swift
//  RentCar
//
//  Created by Jastin on 6/6/21.
//

import Foundation

struct Home {
    
    var image: String
    
    /// You need just to adjust max number and should include new asset with the corresponding number
    static var homeCollectionImages: [Home]  {
        var home = [Home]()
        var number = 1
        repeat {
            home.append(Home(image: "model\(number)"))
            number += 1
        }while number <= 14
        return home
    }
}



