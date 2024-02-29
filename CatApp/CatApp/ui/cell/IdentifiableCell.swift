//
//  IdentifiableCell.swift
//  CatApp
//
//  Created by Jastin on 29/2/24.
//

import Foundation
import UIKit

public protocol IdentifiableCell: AnyObject {
    static var name: String { get }
}

extension IdentifiableCell where Self: UITableViewCell {
    public static var name: String {
        String(describing: self)
    }
}
