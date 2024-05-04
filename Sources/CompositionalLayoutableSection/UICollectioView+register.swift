//
//  File.swift
//
//
//  Created by Ahmed Yamany on 26/10/2023.
//

import UIKit

public protocol IdentifiableView: Identifiable {}

public extension IdentifiableView where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

public extension UICollectionView {
    /// Register a cell class with the collection view and associate it with a reuse identifier
    func register<T: UICollectionViewCell>(_ class: T.Type) where T: IdentifiableView {
        register(T.self, forCellWithReuseIdentifier: T.identifier)
    }

    /// Register a cell class from nib file with the collection view and associate it with a reuse identifier
    func registerFromNib<T: UICollectionViewCell>(_ class: T.Type) where T: IdentifiableView {
        register(UINib(nibName: T.identifier, bundle: nil), forCellWithReuseIdentifier: T.identifier)
    }

    /// Dequeue a reusable cell of a specified class from the collection view
    func dequeueReusableCell<T: UICollectionViewCell>(_ class: T.Type, for indexPath: IndexPath) -> T where T: IdentifiableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Couldn't find UICollectionViewCell for \(T.identifier), make sure the cell is registered with collection view")
        }
        return cell
    }
}

extension UICollectionReusableView: IdentifiableView { }
