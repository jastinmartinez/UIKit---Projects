//
//  ShowViewModel.swift
//  presentation
//
//  Created by Jastin on 2/4/22.
//

import Foundation
import DomainLayer

public final class PageQueryParameter {
    
    private var number: Int
    
    public init(number: Int = 1) {
        self.number = number
    }
    
    public var current: [String: Int] {
        return ["page": number]
    }
    
    func goNext() {
        number += 1
    }
    
    func goBack() {
        number -= 1
    }
    
    func reset() {
        number = 1
    }
}

public protocol ShowViewModelActions {
    var showEntities: [ShowEntity] { get }
    var showsState: ((ShowViewModel.ShowState) -> Void)? { get set }
    func fetchShows()
    func fetchNextShows()
}

public final class ShowViewModel: ShowViewModelActions {
    
    private let showInteractorProtocol: ShowInteractorProtocol
    private let externalImageInteractorProtocol: ExternalImageInteractorProtocol
    private let pageQueryParameter: PageQueryParameter
    public var showsState: ((ShowState) -> Void)? = nil
    public private(set) var showEntities: [ShowEntity] {
        willSet {
            showsState?(.done)
        }
    }

    public init(showInteractorProtocol: ShowInteractorProtocol,
                externalImageInteractorProtocol: ExternalImageInteractorProtocol,
                pageQueryParameter: PageQueryParameter) {
        self.showInteractorProtocol = showInteractorProtocol
        self.externalImageInteractorProtocol = externalImageInteractorProtocol
        self.pageQueryParameter = pageQueryParameter
        self.showEntities = []
    }
    
    public func fetchShows() {
        fetch {
            pageQueryParameter.reset()
        } onSuccess: { [weak self] showEntities in
            self?.showEntities = showEntities
        }
    }
    
    public func fetchNextShows() {
        fetch(queryParameter: {
            pageQueryParameter.goNext()
        }, onSuccess: { [weak self] showEntities in
            self?.showEntities.append(contentsOf: showEntities)
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
