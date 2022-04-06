//
//  ShowDomainRepositoryProtocol.swift
//  domain
//
//  Created by Jastin on 1/4/22.
//

import Foundation

public protocol ShowDomainRepositoryProtocol {
    func fetchShowList(queryParemeter: Dictionary<String,Any>,handler: @escaping ((Result<[ShowEntity],DomainError>) -> Void))
}
