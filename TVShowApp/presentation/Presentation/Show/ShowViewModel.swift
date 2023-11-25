//
//  ShowViewModel.swift
//  presentation
//
//  Created by Jastin on 2/4/22.
//

import Foundation
import DomainLayer
import CloudKit

public protocol ShowViewModelActions {
    var showEntities: [ShowEntity] { get }
    var showsState: ((ShowViewModel.ShowState) -> Void)? { get set }
    func fetchShows()
    func fetchNextShows()
}

public final class ShowViewModel: ShowViewModelActions {

    private let showInteractorProtocol: ShowInteractorProtocol
    private let externalImageInteractorProtocol: ExternalImageInteractorProtocol
    public var showsState: ((ShowState) -> Void)? = nil
    private var _showEntities = [ShowEntity]()
    public var showEntities: [ShowEntity] {
        return _showEntities
    }
    
    public init(showInteractorProtocol: ShowInteractorProtocol,
                externalImageInteractorProtocol: ExternalImageInteractorProtocol) {
        self.showInteractorProtocol = showInteractorProtocol
        self.externalImageInteractorProtocol = externalImageInteractorProtocol
    }
    
    public func fetchShows() {
        showsState?(.loading)
        showInteractorProtocol.fetchShowList(queryParameter: ["page":  1]) { [weak self] showInteractorResult  in
            switch showInteractorResult {
            case .success(let showEntityList):
                self?._showEntities = showEntityList
                self?.showsState?(.done)
            case .failure(let error):
                self?.showsState?(.fail(error))
            }
        }
    }
    
    public func fetchNextShows() { }
}

extension ShowViewModel {
    public enum ShowState {
        case loading
        case done
        case fail(Error)
    }
}
