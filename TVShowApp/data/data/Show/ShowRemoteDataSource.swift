//
//  ShowRemoteDataSource.swift
//  data
//
//  Created by Jastin on 2/4/22.
//

import Foundation
import Alamofire

protocol ShowRemoteDataSourceProtocol {
    init(baseUrl: String)
    func fetchShowList(handler: @escaping ((DataResponse<[ShowModel],AFError>) -> Void))
}

class ShowRemoteDataSource: ShowRemoteDataSourceProtocol {
    
    private let baseUrl: String
    
    required init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func fetchShowList(handler: @escaping ((DataResponse<[ShowModel],AFError>) -> Void)) {
        AF.request(baseUrl,method: .get).responseDecodable(of: [ShowModel].self, completionHandler: handler)
    }
}
