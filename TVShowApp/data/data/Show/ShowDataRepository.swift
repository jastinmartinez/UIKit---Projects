//
//  ShowDataRepository.swift
//  data
//
//  Created by Jastin on 2/4/22.
//

import Foundation
import DomainLayer

public class ShowDataRepository : ShowDomainRepositoryProtocol {
    
    private let showRemoteDataSource: ShowRemoteDataSourceProtocol
    
    public init(showRemoteDataSource: ShowRemoteDataSourceProtocol) {
        self.showRemoteDataSource = showRemoteDataSource
    }
    
    public func fetchShowList(queryParemeter: Dictionary<String,Any>,handler: @escaping ((Result<[ShowEntity],DomainError>) -> Void)) {
        self.showRemoteDataSource.fetchShowList(queryParameter: queryParemeter) { dataResponse in
            switch dataResponse.result {
            case.success(let showModeList):
                handler(.success(showModeList.map({ showModel in return showModel.toShowEntity()})))
            case.failure(let error):
                handler(.failure(AFErrorToDomainErrorHelper.errorTypeOf(error)))
            }
        }
    }
    
    public func fetchShowImage(imageUrl: String, handler: @escaping ((Result<Data?, DomainError>) -> Void)) {
        self.showRemoteDataSource.fetchShowImage(urlImage: imageUrl) { dataResponse in
            switch dataResponse.result {
            case .success(let dataImage):
                handler(.success(dataImage))
            case .failure(let error):
                handler(.failure(AFErrorToDomainErrorHelper.errorTypeOf(error)))
            }
        }
    }
}
