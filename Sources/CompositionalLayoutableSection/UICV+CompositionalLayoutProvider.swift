//
//  UICollectionView+SectionType.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/02/2023.
//

import UIKit

@available(iOS 13.0, *)
extension UICollectionView {
    public func updatecollectionViewCompositionalLayout(with provider: any CompositionalLayoutProvider) {
        provider.registerCells(for: self)
        provider.registerSupplementaryViews(for: self)
        collectionViewLayout = provider.collectionViewCompositionalLayout()
    }
}
