//
//  ShowDataRepository.swift
//  data
//
//  Created by Jastin on 2/4/22.
//

import Foundation
import DomainLayer
import Alamofire

public class ShowDataRepository : ShowDomainRepositoryProtocol {
    
    private let showRemoteDataSource: ShowRemoteDataSourceProtocol
    
    public init(showRemoteDataSource: ShowRemoteDataSourceProtocol) {
        self.showRemoteDataSource = showRemoteDataSource
    }
    
    public func fetchShowList(handler: @escaping ((Result<[ShowEntity],DomainError>) -> Void)) {
        self.showRemoteDataSource.fetchShowList { dataResponse in
            switch dataResponse.result {
            case.success(let showModeList):
                let castToShowEntityList = showModeList.map({showModel in return showModel.toShowEntity()})
                handler(.success(castToShowEntityList))
            case.failure(let error):
                handler(.failure(AFErrorToDomainErrorHelper.errorTypeOf(error)))
            }
        }
    }
}
