//
//  ExternalImageDataRepository.swift
//  DataLayer
//
//  Created by Jastin on 5/4/22.
//

import Foundation
import DomainLayer

public class ExternalImageDataRepository : ExternalImageDomainRepositoryProtocol {
    
    private let externalImageRemoteDataSourceProtocol: ExternalImageRemoteDataSourceProtocol
    
    public required init(externalImageRemoteDataSourceProtocol: ExternalImageRemoteDataSourceProtocol) {
        self.externalImageRemoteDataSourceProtocol = externalImageRemoteDataSourceProtocol
    }
    
    public func fetchExternalImage(imageUrl: String, handler: @escaping ((Result<Data?, DomainError>) -> Void)) {
        externalImageRemoteDataSourceProtocol.fecthShowEpisodeList(urlImage: imageUrl) {dataResponse in
            switch dataResponse.result {
            case .success(let data):
                handler(.success(data))
            case .failure(_):
                handler(.failure(.NotValid))
            }
        }
    }
}
