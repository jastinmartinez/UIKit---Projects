//
//  ShowRemoteDataSource.swift
//  data
//
//  Created by Jastin on 2/4/22.
//

import Foundation
import Alamofire

public protocol ShowRemoteDataSourceProtocol {
    init(baseUrl: String)
    func fetchShowList(queryParameter: Parameters,handler: @escaping ((DataResponse<[ShowModel],AFError>) -> Void))
    func fetchShowImage(urlImage: String,handler: @escaping ((DataResponse<Data?,AFError>) -> Void))
}

public class ShowRemoteDataSource: ShowRemoteDataSourceProtocol {
    private let baseUrl: String
    
    public required init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    public func fetchShowList(queryParameter: Parameters,handler: @escaping ((DataResponse<[ShowModel],AFError>) -> Void)) {
        AF.request(baseUrl,method: .get, parameters: queryParameter).responseDecodable(of: [ShowModel].self, completionHandler: handler)
    }
    
    public func fetchShowImage(urlImage: String, handler: @escaping ((DataResponse<Data?,AFError>) -> Void)) {
        AF.request(urlImage,method: .get).response(completionHandler: handler)
    }
}
