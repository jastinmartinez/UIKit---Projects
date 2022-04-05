//
//  ShowEpisodeDataRepository.swift
//  DataLayer
//
//  Created by Jastin on 5/4/22.
//

import Foundation
import DomainLayer

class ShowEpisodeDataRepository : ShowEpisodeDomainRepositoryProtocol {
    
    private let showEpisodeRemoteDataSourceProtocol: ShowEpisodeRemoteDataSourceProtocol
    
    init(showEpisodeRemoteDataSourceProtocol: ShowEpisodeRemoteDataSourceProtocol) {
        self.showEpisodeRemoteDataSourceProtocol = showEpisodeRemoteDataSourceProtocol
    }
    
    func fetchShowEpisodeList(showId: Int, handler: @escaping ((Result<[ShowEpisodeEntity], DomainError>) -> Void)) {
        self.showEpisodeRemoteDataSourceProtocol.fecthShowEpisodeList(showId: showId) { dataResponse in
            switch dataResponse.result {
            case .success(let showEpisodeModelList):
                handler(.success(showEpisodeModelList.map({ showEpisodeModel in
                    showEpisodeModel.toShowEpisodeEntity()
                })))
            case .failure(let afError):
                handler(.failure(AFErrorToDomainErrorHelper.errorTypeOf(afError)))
            }
        }
    }
}
