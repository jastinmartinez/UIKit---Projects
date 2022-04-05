//
//  ShowInteractor.swift
//  domain
//
//  Created by Jastin on 1/4/22.
//

import Foundation

public protocol ShowInteractorProtocol {
    func fetchShowList(queryParemeter: Dictionary<String,Any>, handler: @escaping ((Result<[ShowEntity],DomainError>) -> Void))
    func fetchShowImage(imageUrl: String,handler: @escaping ((Result<Data?,DomainError>) -> Void))
}

public class ShowInteractor : ShowInteractorProtocol {

    private let showDomainRepositoryProtocol: ShowDomainRepositoryProtocol
    
    public init(showDomainRepositoryProtocol: ShowDomainRepositoryProtocol) {
        self.showDomainRepositoryProtocol = showDomainRepositoryProtocol
    }
    
    public func fetchShowList(queryParemeter: Dictionary<String,Any>,handler: @escaping ((Result<[ShowEntity],DomainError>) -> Void)) {
        self.showDomainRepositoryProtocol.fetchShowList(queryParemeter: queryParemeter, handler: handler)
    }
    
    public func fetchShowImage(imageUrl: String, handler: @escaping ((Result<Data?, DomainError>) -> Void)) {
        self.showDomainRepositoryProtocol.fetchShowImage(imageUrl: imageUrl, handler: handler)
    }
}
