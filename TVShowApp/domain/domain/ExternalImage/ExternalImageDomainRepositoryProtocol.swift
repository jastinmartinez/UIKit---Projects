//
//  ExternalImageDomainRepositoryProtocol.swift
//  DomainLayer
//
//  Created by Jastin on 5/4/22.
//

import Foundation
public protocol ExternalImageDomainRepositoryProtocol {
    func fetchExternalImage(imageUrl: String,handler: @escaping ((Result<Data?,DomainError>) -> Void))
}
