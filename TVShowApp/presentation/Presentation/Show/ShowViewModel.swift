//
//  ShowViewModel.swift
//  presentation
//
//  Created by Jastin on 2/4/22.
//

import Foundation
import DomainLayer
import CloudKit

public protocol DidSetShowEntityList : AnyObject {
    func notifyViewController(_ message: String?)
}

public class ShowViewModel {
    public var preFetchOperationQuee:[Int:IndexPath?] = [:]
    public var isFetchingNextShowEntityList = false
    private var pageNumberList: [Int] = [1]
    private let showInteractorProtocol: ShowInteractorProtocol
    public var showEntityList = [ShowEntity]()
    private var showImageCached = NSCache<NSString,NSData>()
    public weak var didSetShowEntityList: DidSetShowEntityList?
    
    public init(showInteractorProtocol: ShowInteractorProtocol) {
        self.showInteractorProtocol = showInteractorProtocol
    }

    public func fetchNextShowList(handler: (() -> ())?) {
        if pageNumberList[pageNumberList.count - 1] > -1 {
            self.isFetchingNextShowEntityList = true
            self.fetchShowList()
            self.pageNumberList.append(pageNumberList.count + 1)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            handler?()
        }
    }
    
    public func fetchShowList() {
        self.showInteractorProtocol.fetchShowList(queryParemeter: ["page": pageNumberList[pageNumberList.count - 1]]) { showInteractorResult in
            self.isFetchingNextShowEntityList = false
            switch showInteractorResult {
            case .success(let showEntityList):
                self.showEntityList.append(contentsOf: showEntityList)
                self.didSetShowEntityList?.notifyViewController(nil)
            case .failure(let error):
                self.pageNumberList[self.pageNumberList.count - 1] = -1
                self.didSetShowEntityList?.notifyViewController(error.errorDescription)
            }
        }
    }
    
    public func setShowEntityById(showEntityID: Int, handler: ((ShowEntity) -> Void)?) {
        guard let showEntityIndex = self.showEntityList.firstIndex(where: { showEntity in showEntity.id == showEntityID }) else {
            return
        }
        self.setShowEntityByIndex(index: showEntityIndex, handler: handler)
    }
   
    public func setShowEntityByIndex(index: Int,handler: ((ShowEntity) -> Void)?) {
        var showEntity = self.showEntityList[index]
        if let showImageEntity = showEntity.image {
            let imageKey = showImageEntity.original as NSString
            if let cachedImageData = self.showImageCached.object(forKey: imageKey) {
                showEntity.image?.data = Data(referencing: cachedImageData)
                handler?(showEntity)
                self.showEntityList[index] = showEntity
                return
            }
            self.showInteractorProtocol.fetchShowImage(imageUrl: showImageEntity.original) { fetchShowImageResult in
                switch fetchShowImageResult {
                case .success(let data):
                    if let imageData = data  {
                        showEntity.image?.data = imageData
                        self.showEntityList[index] = showEntity
                        self.showImageCached.setObject(NSData(data: imageData), forKey: imageKey)
                    }
                    DispatchQueue.main.async {
                        handler?(showEntity)
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
}
