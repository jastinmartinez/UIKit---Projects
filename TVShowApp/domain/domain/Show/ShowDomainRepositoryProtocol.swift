//
//  ShowDomainRepositoryProtocol.swift
//  domain
//
//  Created by Jastin on 1/4/22.
//

import Foundation

protocol ShowDomainRepositoryProtocol {
    func fetchShowList(handler: @escaping (([ShowEntity]) -> Void))
}
