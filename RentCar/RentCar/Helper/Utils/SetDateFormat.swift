//
//  DateFormat.swift
//  RentCar
//
//  Created by Jastin on 20/6/21.
//

import Foundation

final class SetDateFormat {
    
    var to: DateFormatter  {
        let dateFomart = DateFormatter()
        dateFomart.dateFormat = "yyyy-MM-dd"
        return dateFomart
    }
}
