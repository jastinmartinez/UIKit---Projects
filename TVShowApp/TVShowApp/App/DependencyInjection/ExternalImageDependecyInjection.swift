//
//  ExternalImageDependencyInjection.swift
//  TVShowApp
//
//  Created by Jastin on 5/4/22.
//

import Foundation
import DataLayer
import DomainLayer
import PresentationLayer

final class ExternalImageDependencyInjection {
    class func setExternalInteractor() -> ExternalImageInteractorProtocol {
        let externalImageRemoteDataSource = ExternalImageRemoteDataSource()
        let externalImageDataRepository = ExternalImageDataRepository(externalImageRemoteDataSourceProtocol: externalImageRemoteDataSource)
        let externalImageInteractor = ExternalImageInteractor(externalImageDomainRepositoryProtocol: externalImageDataRepository)
        return externalImageInteractor
    }
}
