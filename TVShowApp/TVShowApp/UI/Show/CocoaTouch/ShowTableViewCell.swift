//
//  ShowTableViewCell.swift
//  TVShowApp
//
//  Created by Jastin on 3/4/22.
//

import UIKit
import DomainLayer


public final class ShowTableViewCell : UITableViewCell {
    
    public var isFavorite: ((ShowEntity) -> Void)?
    private var showEntity: ShowEntity!
    
    public func setShowEntity(_ entity: ShowEntity) {
        showEntity = entity
    }
    
    public func setFavorite() {
        showEntity.setFavorite()
        notifyIsFavorite()
    }
    
    public func setNotFavorite() {
        showEntity.setNotFavorite()
        notifyIsFavorite()
    }
    
    private func notifyIsFavorite() {
        isFavorite?(showEntity)
    }
}
