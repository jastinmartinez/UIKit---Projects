//
//  ExternalImageRemoteDataSource.swift
//  DataLayer
//
//  Created by Jastin on 5/4/22.
//

import Foundation
import Alamofire

public protocol ExternalImageRemoteDataSourceProtocol {
    func fecthShowEpisodeList(urlImage: String,handler: @escaping ((DataResponse<Data?,AFError>) -> Void))
}

public class ExternalImageRemoteDataSource : ExternalImageRemoteDataSourceProtocol {
    public init() {}
    public func fecthShowEpisodeList(urlImage: String,handler: @escaping ((DataResponse<Data?,AFError>) -> Void)) {
        AF.request(urlImage, method: .get).response(completionHandler: handler)
    }
}

