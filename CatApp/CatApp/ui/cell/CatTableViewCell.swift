//
//  CatTableViewCell.swift
//  CatApp
//
//  Created by Jastin on 28/2/24.
//

import Foundation
import UIKit

public class CatTableViewCell: UITableViewCell, IdentifiableCell {
    
    func setCat(_ cat: Cat) {
        
    }
    
    func setImage(_ image: DataStatePresenter<Data>) {
        switch image {
        case .loading:
            break
        case .success(let image):
            break
        case .failure(let error):
            break
        }
    }
}
