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

final class ShowEpisodeDependeyInjection {
    class func setShowEpisodeViewModelDependecy() -> ShowEpisodeViewModel {
        let showEpisodeRemoteDataSource = ShowEpisodeRemoteDataSource(baseUrl: AppEnviroment.shared.baseUrl, resource: "episodes")
        let showEpisodeDataRepository = ShowEpisodeDataRepository(showEpisodeRemoteDataSourceProtocol: showEpisodeRemoteDataSource)
        let showEpisodeInteractor = ShowEpisodeInteractor(showEpisodeDomainRepositoryProtocol: showEpisodeDataRepository)
        let showEpisodeViewModel = ShowEpisodeViewModel(showEpisodeInteractorProtocol: showEpisodeInteractor)
        return showEpisodeViewModel
    }
}
