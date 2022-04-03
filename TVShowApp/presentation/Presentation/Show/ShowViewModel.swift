//
//  ShowViewModel.swift
//  presentation
//
//  Created by Jastin on 2/4/22.
//

import Foundation
import DomainLayer
import RxSwift
import RxRelay

public class ShowViewModel {
    
    private let showInteractorProtocol: ShowInteractorProtocol
    public let showEntityList = PublishSubject<[ShowEntity]>()
    
    public init(showInteractorProtocol: ShowInteractorProtocol) {
        self.showInteractorProtocol = showInteractorProtocol
    }
    
    public func fetchShowList() {
        
        self.showInteractorProtocol.fetchShowList { showInteractorResult in
            switch showInteractorResult {
            case .success(let showEntityList):
                self.showEntityList.onNext(showEntityList)
                self.showEntityList.onCompleted()
            case .failure(let domainError):
                self.showEntityList.onError(domainError)
                self.showEntityList.onCompleted()
            }
        }
    }
}
