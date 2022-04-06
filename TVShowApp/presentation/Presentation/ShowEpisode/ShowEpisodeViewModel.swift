//
//  ShowEpisodeViewModel.swift
//  PresentationLayer
//
//  Created by Jastin on 5/4/22.
//

import Foundation
import DomainLayer

public protocol DidSetShowEpisodeEntityList : AnyObject {
    func DidSetShowEpisodeEntityListNotification()
}

public class ShowEpisodeViewModel {
    
    public weak var didSetShowEpisodeEntityList: DidSetShowEpisodeEntityList?
    private let showEpisodeInteractorProtocol: ShowEpisodeInteractorProtocol
    private let externalImageInteractorProtocol: ExternalImageInteractorProtocol
    public var showEpisodeEntityListGropBySeason:[Int:[ShowEpisodeEntity]] = [:]
   
    public required init(showEpisodeInteractorProtocol: ShowEpisodeInteractorProtocol, externalImageInteractorProtocol: ExternalImageInteractorProtocol) {
        self.showEpisodeInteractorProtocol = showEpisodeInteractorProtocol
        self.externalImageInteractorProtocol = externalImageInteractorProtocol
    }
    
    public func fetchShowEpisodeListById(showId: Int) {
        self.showEpisodeInteractorProtocol.fecthShowEpisodeList(showId: showId) { resultResponse in
            switch resultResponse {
            case .success(let showEpisodeEntityList):
                self.showEpisodeEntityListGropBySeason = Dictionary(grouping: showEpisodeEntityList, by: { showEpisodeEntity in return showEpisodeEntity.season })
                self.didSetShowEpisodeEntityList?.DidSetShowEpisodeEntityListNotification()
            case .failure(_):
                break
            }
        }
    }
    
    public func fetchShowEpisodeImage(season: Int,number: Int, handler: ( (ShowEpisodeEntity) -> Void)?) {
        guard var showEpisodeEntityList = self.showEpisodeEntityListGropBySeason[season],let showEpisodeImageEntity = showEpisodeEntityList[number].image else {
            return
        }
        self.externalImageInteractorProtocol.fetchExternalImage(imageUrl: showEpisodeImageEntity.original) { resultResponse in
            switch resultResponse {
            case .success(let data):
                showEpisodeEntityList[number].image?.imageData = data
                self.showEpisodeEntityListGropBySeason[season] = showEpisodeEntityList
                handler?(showEpisodeEntityList[number])
            case .failure(_):
                break
            }
        }
    }
}
