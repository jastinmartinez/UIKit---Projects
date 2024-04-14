//
//  CatCellController.swift
//  CatApp
//
//  Created by Jastin on 14/4/24.
//

import Foundation
import UIKit

public class CatCellController {
    
    private var imageLoaderTask: ImageLoaderTask?
    private let cat: Cat
    private let imageLoaderAdapter: ImageLoaderAdapter
    
    init(cat: Cat, imageLoaderAdapter: ImageLoaderAdapter) {
        self.imageLoaderTask = nil
        self.cat = cat
        self.imageLoaderAdapter = imageLoaderAdapter
    }
    
    func view(_ tableView: UITableView,
              cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let catCell: CatTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        catCell.setCat(cat)
        catCell.retryButton.isHidden = true
        catCell.catImageView.image = nil
        catCell.containerView.startShimmering()
        
        let loadImage = { [weak self, weak catCell] in
            guard let self = self else { return }
            
            self.imageLoaderTask = self.imageLoaderAdapter.load(from: cat.id, completion: { [weak catCell] result in
                let data = try? result.get()
                let image = data.map(UIImage.init) ?? nil
                catCell?.catImageView.image = image
                catCell?.retryButton.isHidden = (image != nil)
                catCell?.containerView.stopShimmering()
            })
        }
        catCell.onRetry = loadImage
        loadImage()
        return catCell
    }
    
    func preload() {
        self.imageLoaderTask = self.imageLoaderAdapter.load(from: cat.id, completion: {  result in } )
    }
    
    deinit {
        imageLoaderTask?.cancel()
    }
}
