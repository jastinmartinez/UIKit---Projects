//
//  ShowEpisodeDependencyInjection.swift
//  TVShowApp
//
//  Created by Jastin on 5/4/22.
//

import Foundation
import DataLayer
import DomainLayer
import PresentationLayer

final class ShowEpisodeDependencyInjection {
    class func setShowEpisodeViewModelDependency() -> ShowEpisodeViewModel {
        let showEpisodeRemoteDataSource = ShowEpisodeRemoteDataSource(baseUrl: AppEnvironment.shared.baseUrl, resource: "episodes")
        let showEpisodeDataRepository = ShowEpisodeDataRepository(showEpisodeRemoteDataSourceProtocol: showEpisodeRemoteDataSource)
        let showEpisodeInteractor = ShowEpisodeInteractor(showEpisodeDomainRepositoryProtocol: showEpisodeDataRepository)
        let externalImageDependency = ExternalImageDependencyInjection.setExternalInteractor()
        let showEpisodeViewModel = ShowEpisodeViewModel(showEpisodeInteractorProtocol: showEpisodeInteractor, externalImageInteractorProtocol: externalImageDependency)
        return showEpisodeViewModel
    }
}
