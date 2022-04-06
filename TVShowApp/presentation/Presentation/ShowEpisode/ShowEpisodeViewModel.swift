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
    public var showEpisodeEntityListGropBySeason:[Int:[ShowEpisodeEntity]] = [:]
   
    public required init(showEpisodeInteractorProtocol: ShowEpisodeInteractorProtocol) {
        self.showEpisodeInteractorProtocol = showEpisodeInteractorProtocol
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
}
