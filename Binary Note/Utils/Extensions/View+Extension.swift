//
//  View+Extension.swift
//  Binary Note
//
//  Created by Ye linn htet on 1/15/23.
//
import Foundation
import UIKit

extension UIViewController {
    static var identifier: String {
        String(describing: self)
    }
}

extension UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
}

extension UITableView {
    func registerForCell(identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    func dequeueCell<T:UITableViewCell>(identifier: String, indexPath: IndexPath)->T {
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
            return UITableViewCell() as! T
        }
        return cell
    }
}

extension UICollectionViewCell {
    static var identifier : String {
        String(describing: self)
    }
}

extension UICollectionView {
    
    func registerForCell(identifier: String) {
        register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    
    func dequeueCell<C:UICollectionViewCell>(identifier:String, indexPath: IndexPath)->C {
        guard let cell = dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? C else {
            return UICollectionViewCell() as! C
        }
        return cell
    }
}

