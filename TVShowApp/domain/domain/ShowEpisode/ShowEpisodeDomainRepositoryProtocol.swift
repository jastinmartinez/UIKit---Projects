//
//  ShowEpisodeDomainRepositoryProtocol.swift
//  DomainLayer
//
//  Created by Jastin on 5/4/22.
//

import Foundation

public protocol ShowEpisodeDomainRepositoryProtocol {
    func fetchShowEpisodeList(showId: Int, handler: @escaping ((Result<[ShowEpisodeEntity],DomainError>) -> Void))
}
