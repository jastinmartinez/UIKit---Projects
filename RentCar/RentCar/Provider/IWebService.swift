//
//  WebService.swift
//  RentCar
//
//  Created by Jastin on 17/5/21.
//

import Foundation

struct IGetResource<T> {
    let url: URL
    let JsonToObject: (Data) -> T?
}


struct IPostResource<T : Encodable> {
    let url: URL
    let model: T
    let JsonToObject: (Data) -> T?
}

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
    
    func postRequest<T>(resource: IPostResource<T>,completion: @escaping (T?)->())
    {
        var request = URLRequest(url: resource.url)
        request.httpMethod = HttpMethods.POST.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(resource.model)
        print(resource.model)
        URLSession.shared.dataTask(with: request) { data,response,error in
            if let data = data {
                DispatchQueue.main.async {
                    print(data)
                    completion(resource.JsonToObject(data))
                }
            }
        }.resume()
    }
    
}
