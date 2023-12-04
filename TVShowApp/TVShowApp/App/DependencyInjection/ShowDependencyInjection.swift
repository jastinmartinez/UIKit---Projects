//
//  ShowDependencyInjection.swift
//  TVShowApp
//
//  Created by Jastin on 2/4/22.
//

import Foundation
import PresentationLayer
import DomainLayer
import DataLayer

final class ShowDependencyInjection {
    class func setShowViewModelDependency() -> ShowViewModel {
        let showRemoteDataSource = ShowRemoteDataSource(baseUrl: AppEnvironment.shared.baseUrl)
        let showDataRepository = ShowDataRepository(showRemoteDataSource: showRemoteDataSource)
        let showInteractor = ShowInteractor(showDomainRepositoryProtocol: showDataRepository)
        let showViewModel = ShowViewModel(showInteractorProtocol: showInteractor, pageQueryParameter: PageQueryParameter())
        return showViewModel
    }
}



