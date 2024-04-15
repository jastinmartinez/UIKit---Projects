//
//  CatCellController.swift
//  CatApp
//
//  Created by Jastin on 14/4/24.
//

import Foundation
import UIKit

protocol CatCellControllerDelegate {
    func didRequestImage()
    func didCancelImageRequest()
}

public class CatCellController: CatImageView {
  
    private let delegate: CatCellControllerDelegate
    private var cell: CatTableViewCell?
   
    init(delegate: CatCellControllerDelegate) {
        self.delegate = delegate
    }
    
    func display(_ viewModel: CatImageViewModel<UIImage>) {
        cell?.setTags(viewModel.tags)
        cell?.catImageView.image = viewModel.image
        cell?.retryButton.isHidden = !viewModel.shouldRetry
        if viewModel.isLoading {
            cell?.containerView.startShimmering()
        } else {
            cell?.containerView.stopShimmering()
        }
    }
    
    func view(_ tableView: UITableView,
              cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.cell = bindFor(tableView, cellForRowAt: indexPath)
        delegate.didRequestImage()
        return cell!
    }
    
    private func bindFor(_ tableView: UITableView,
                         cellForRowAt indexPath: IndexPath) -> CatTableViewCell {
        let catCell: CatTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        catCell.retryButton.isHidden = true
        catCell.catImageView.image = nil
        catCell.onRetry = delegate.didRequestImage
        return catCell
    }
    
    func preload() {
        delegate.didRequestImage()
    }
    
    func cancel() {
        delegate.didCancelImageRequest()
    }
}
