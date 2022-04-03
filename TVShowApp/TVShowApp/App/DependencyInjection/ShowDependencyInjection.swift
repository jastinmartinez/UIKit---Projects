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

class ShowDependencyInjection {
    
    private let appEnviroment: AppEnviroment
    
    init(appEnviromet: AppEnviroment = AppEnviroment.shared) {
        self.appEnviroment = appEnviromet
    }
    
    func setShowViewModelDependecy() -> ShowViewModel {
        let showRemoteDataSource = ShowRemoteDataSource(baseUrl: appEnviroment.baseUrl)
        let showDataRepository = ShowDataRepository(showRemoteDataSource: showRemoteDataSource)
        let showInteractor = ShowInteractor(showDomainRepositoryProtocol: showDataRepository)
        let showViewModel = ShowViewModel(showInteractorProtocol: showInteractor)
        return showViewModel
    }
}
