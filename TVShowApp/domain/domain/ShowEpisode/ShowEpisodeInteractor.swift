//
//  ShowEpisodeInteractor.swift
//  DomainLayer
//
//  Created by Jastin on 5/4/22.
//

import Foundation

public protocol ShowEpisodeInteractorProtocol {
    func fecthShowEpisodeList(showId: Int, handler: @escaping ((Result<[ShowEpisodeEntity],DomainError>) -> Void))
}

public class ShowEpisodeInteractor : ShowEpisodeInteractorProtocol {
    
    private let showEpisodeDomainRepositoryProtocol: ShowEpisodeDomainRepositoryProtocol
    
    public required init(showEpisodeDomainRepositoryProtocol: ShowEpisodeDomainRepositoryProtocol) {
        self.showEpisodeDomainRepositoryProtocol = showEpisodeDomainRepositoryProtocol
    }
    
    public func fecthShowEpisodeList(showId: Int, handler: @escaping ((Result<[ShowEpisodeEntity], DomainError>) -> Void)) {
        self.showEpisodeDomainRepositoryProtocol.fetchShowEpisodeList(showId: showId, handler: handler)
    }
}

