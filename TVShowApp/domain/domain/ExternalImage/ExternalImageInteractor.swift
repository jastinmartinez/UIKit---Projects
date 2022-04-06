//
//  ExternalImageInteractor.swift
//  DomainLayer
//
//  Created by Jastin on 5/4/22.
//

import Foundation

public protocol ExternalImageInteractorProtocol {
    func fetchExternalImage(imageUrl: String,handler: @escaping ((Result<Data?,DomainError>) -> Void))
}

public class ExternalImageInteractor : ExternalImageInteractorProtocol {
    
    private let externalImageDomainRepositoryProtocol: ExternalImageDomainRepositoryProtocol
    
    public required init(externalImageDomainRepositoryProtocol: ExternalImageDomainRepositoryProtocol) {
        self.externalImageDomainRepositoryProtocol = externalImageDomainRepositoryProtocol
    }
    
    public func fetchExternalImage(imageUrl: String, handler: @escaping ((Result<Data?, DomainError>) -> Void)) {
        self.externalImageDomainRepositoryProtocol.fetchExternalImage(imageUrl: imageUrl, handler: handler)
    }
}
