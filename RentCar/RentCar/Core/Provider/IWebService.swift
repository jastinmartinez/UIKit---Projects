//
//  WebService.swift
//  RentCar
//
//  Created by Jastin on 17/5/21.
//

import Foundation

final class IWebService {
    
    func getRequest<T>(resource: IGetResource<T>, completion: @escaping (T?)->()) {
        URLSession.shared.dataTask(with: resource.url) { data,response,error in
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.JsonToObject(data))
                }
            }
        }.resume()
    }
    
    func postRequest<T>(resource: IPostResource<T>,completion: @escaping (Data?, URLResponse?,Error?) -> ())
    {
        var resource = resource
        resource.urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        resource.urlRequest.httpBody = try? JSONEncoder().encode(resource.model)
        URLSession.shared.dataTask(with: resource.urlRequest){ data, response,error in
            DispatchQueue.main.async {
               completion(data,response ,error)
            }
        }.resume()
    }
    
}
