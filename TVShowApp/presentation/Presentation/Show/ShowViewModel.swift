//
//  ShowViewModel.swift
//  presentation
//
//  Created by Jastin on 2/4/22.
//

import Foundation
import DomainLayer


public protocol DidSetShowEntityList : AnyObject {
    func notifyViewController()
}

public class ShowViewModel {
    
    private let showInteractorProtocol: ShowInteractorProtocol
    public var showEntityList = [ShowEntity]()
    private var showImageCached = NSCache<NSString,NSData>()
    public weak var didSetShowEntityList: DidSetShowEntityList?
    
    public init(showInteractorProtocol: ShowInteractorProtocol) {
        self.showInteractorProtocol = showInteractorProtocol
    }
    
    public func fetchShowList() {
        self.showInteractorProtocol.fetchShowList { showInteractorResult in
            switch showInteractorResult {
            case .success(let showEntityList):
                self.showEntityList = showEntityList
                self.didSetShowEntityList?.notifyViewController()
            case .failure(_):
                break
            }
        }
    }
    
    fileprivate func setShowImageEntityToList(showEntity: ShowEntity) {
        guard let indexOfEntity = showEntityList.firstIndex(where: {$0.id == showEntity.id}) else {
            return
        }
        self.showEntityList[indexOfEntity] = showEntity
    }
    
    public func fectShowImage(_ showEntity: ShowEntity,handler: ((ShowEntity) -> Void)?) {
        DispatchQueue.main.async { [weak self] in
            var mutableCopyShowEntity = showEntity
            let imageKey = showEntity.image.original as NSString
            if let cachedImageData = self?.showImageCached.object(forKey: imageKey) {
                mutableCopyShowEntity.image.data = Data(referencing: cachedImageData)
                self?.setShowImageEntityToList(showEntity: mutableCopyShowEntity)
                handler?(mutableCopyShowEntity)
                return
            }
            self?.showInteractorProtocol.fetchShowImage(imageUrl: showEntity.image.original) { fetchShowImageResult in
                switch fetchShowImageResult {
                case .success(let data):
                    guard let imageData = data else {
                        return
                    }
                    mutableCopyShowEntity.image.data = imageData
                    self?.setShowImageEntityToList(showEntity: showEntity)
                    self?.showImageCached.setObject(NSData(data: imageData), forKey: imageKey)
                    handler?(mutableCopyShowEntity)
                case .failure(_):
                    break
                }
            }
        }
    }
}
