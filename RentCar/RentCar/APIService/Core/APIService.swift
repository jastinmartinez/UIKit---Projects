//
//  PostRequest.swift
//  RentCar
//
//  Created by Jastin on 30/5/21.
//

import Foundation
import Alamofire

final class APIService {
    func request(url: URLRequest,completion: @escaping (Data?,HTTPURLResponse?,AFError?) -> () )  {
        AF.request(url).response{completion($0.data,$0.response,$0.error)}
    }
}
 
