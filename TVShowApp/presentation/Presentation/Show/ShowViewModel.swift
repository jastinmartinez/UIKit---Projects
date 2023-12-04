//
//  ShowViewModel.swift
//  presentation
//
//  Created by Jastin on 2/4/22.
//

import Foundation
import DomainLayer

public protocol ShowViewModelActions {
    var shows: [ShowEntity] { get }
    var showsState: ((ShowViewModel.ShowState) -> Void)? { get set }
    func fetchShows()
    func fetchNextShows()
}

public final class ShowViewModel: ShowViewModelActions {
    
    private let showInteractorProtocol: ShowInteractorProtocol
    private let pageQueryParameter: PageQueryParameter
    public var showsState: ((ShowState) -> Void)?
    public private(set) var shows: [ShowEntity] {
        willSet {
            showsState?(.done)
        }
    }

    public init(showInteractorProtocol: ShowInteractorProtocol,
                pageQueryParameter: PageQueryParameter) {
        self.showInteractorProtocol = showInteractorProtocol
        self.pageQueryParameter = pageQueryParameter
        self.shows = []
    }
    
    public func fetchShows() {
        fetch(queryParameter: {
            pageQueryParameter.reset()
        }, onSuccess: { [weak self] showEntities in
            self?.shows = showEntities
        })
    }
    
    public func fetchNextShows() {
        fetch(queryParameter: {
            pageQueryParameter.goNext()
        }, onSuccess: { [weak self] showEntities in
            self?.shows.append(contentsOf: showEntities)
        }, onFailure: { [weak self] in
            self?.pageQueryParameter.goBack()
        })
    }
    
    private func fetch(queryParameter: () -> Void,
                       onSuccess: @escaping ([ShowEntity]) -> Void,
                       onFailure: (() -> Void)? = nil) {
        showsState?(.loading)
        queryParameter()
        showInteractorProtocol.fetchShowList(queryParameter: pageQueryParameter.current) { [weak self] showResult in
            switch showResult {
            case let .success(showEntities):
                onSuccess(showEntities)
            case let .failure(error):
                self?.showsState?(.fail(error))
                onFailure?()
            }
        }
    }
}

extension ShowViewModel {
    public enum ShowState {
        case loading
        case done
        case fail(Error)
    }
}
