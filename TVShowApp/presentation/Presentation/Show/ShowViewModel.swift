//
//  ShowViewModel.swift
//  presentation
//
//  Created by Jastin on 2/4/22.
//

import Foundation
import DomainLayer
import CloudKit


public class ShowViewModel {

    private let showInteractorProtocol: ShowInteractorProtocol
    private let externalImageInteractorProtocol: ExternalImageInteractorProtocol
    public var showEntityList = [ShowEntity]()
    public var showsState: ((ShowState) -> Void)? = nil
    
    public init(showInteractorProtocol: ShowInteractorProtocol, externalImageInteractorProtocol: ExternalImageInteractorProtocol) {
        self.showInteractorProtocol = showInteractorProtocol
        self.externalImageInteractorProtocol = externalImageInteractorProtocol
    }
    
    public func fetchShowList() {
        showsState?(.loading)
        showInteractorProtocol.fetchShowList(queryParameter: ["page":  1]) { [weak self] showInteractorResult  in
            switch showInteractorResult {
            case .success(let showEntityList):
                self?.showEntityList = showEntityList
                self?.showsState?(.done)
            case .failure(let error):
                self?.showsState?(.fail(error))
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
