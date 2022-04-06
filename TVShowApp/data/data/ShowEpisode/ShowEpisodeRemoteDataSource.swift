//
//  ShowEpisodeRemoteDataSource.swift
//  DataLayer
//
//  Created by Jastin on 5/4/22.
//

import Foundation
import Alamofire

public protocol ShowEpisodeRemoteDataSourceProtocol {
    init(baseUrl: String, resource: String)
    func fecthShowEpisodeList(showId: Int,handler: @escaping ((DataResponse<[ShowEpisodeModel],AFError>) -> Void))
}

public class ShowEpisodeRemoteDataSource : ShowEpisodeRemoteDataSourceProtocol {
    
    private let baseUrl: String
    private let resource: String
    
    public required init(baseUrl: String, resource: String) {
        self.baseUrl = baseUrl
        self.resource = resource
    }
    
    public func fecthShowEpisodeList(showId: Int, handler: @escaping ((DataResponse<[ShowEpisodeModel], AFError>) -> Void)) {
        var urlPath: String {
            return String.init(format: self.baseUrl + "/\(showId)/" + self.resource)
        }
        AF.request(urlPath, method: .get).responseDecodable(of: [ShowEpisodeModel].self ,completionHandler: handler)
    }
}


