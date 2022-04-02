//
//  ShowInteractor.swift
//  domain
//
//  Created by Jastin on 1/4/22.
//

import Foundation

protocol ShowInteractorProtocol {
    func fetchShowList(handler: @escaping ((Result<[ShowEntity],DomainError>) -> Void))
}

class ShowInteractor : ShowInteractorProtocol {
    
    private let showDomainRepositoryProtocol: ShowDomainRepositoryProtocol
    
    init(showDomainRepositoryProtocol: ShowDomainRepositoryProtocol) {
        self.showDomainRepositoryProtocol = showDomainRepositoryProtocol
    }
    
    func fetchShowList(handler: @escaping ((Result<[ShowEntity],DomainError>) -> Void)) {
        self.showDomainRepositoryProtocol.fetchShowList(handler: handler)
    }
}
