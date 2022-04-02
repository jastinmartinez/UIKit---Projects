//
//  ShowDataRepository.swift
//  data
//
//  Created by Jastin on 2/4/22.
//

import Foundation
import domain
import Alamofire

class ShowDataRepository : ShowDomainRepositoryProtocol {
    
    private let showRemoteDataSource: ShowRemoteDataSourceProtocol
    
    init(showRemoteDataSource: ShowRemoteDataSourceProtocol) {
        self.showRemoteDataSource = showRemoteDataSource
    }
    
    func fetchShowList(handler: @escaping ((Result<[ShowEntity],DomainError>) -> Void)) {
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
