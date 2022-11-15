//
//  UITableView+Cells.swift
//  BookStore_AdrielFreire
//
//  Created by Adriel Freire on 15/11/22.
//

import UIKit
extension UITableView {
    func registerCell(type: UITableViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: identifier ?? cellId)
    }
    
    func dequeueCell<T: UITableViewCell>(withType type: T.Type,
                                         for indexPath: IndexPath,
                                         configure: @escaping ((T) -> Void)) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: type.identifier, for: indexPath)
        guard let cell = cell as? T else {
            fatalError()
        }
        
        configure(cell)
        return cell
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

