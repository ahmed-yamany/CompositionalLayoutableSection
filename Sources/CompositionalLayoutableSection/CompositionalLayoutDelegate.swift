//
//  CompositionalLayoutDelegate.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit


@available(iOS 13.0, *)
open class CompositionalLayoutDelegate: NSObject, UICollectionViewDelegate {
    open var profider: any CompositionalLayoutProvider
    
    public init(_ profider: any CompositionalLayoutProvider) {
        self.profider = profider
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = self.profider.getSection(at: indexPath)
        section.delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
}
