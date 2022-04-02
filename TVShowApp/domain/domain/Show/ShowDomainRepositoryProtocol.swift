//
//  ShowDomainRepositoryProtocol.swift
//  domain
//
//  Created by Jastin on 1/4/22.
//

import Foundation

public protocol ShowDomainRepositoryProtocol {
    func fetchShowList(handler: @escaping ((Result<[ShowEntity],DomainError>) -> Void))
}
