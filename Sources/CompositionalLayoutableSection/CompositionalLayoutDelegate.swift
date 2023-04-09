//
//  CompositionalLayoutDelegate.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit


@available(iOS 13.0, *)
class CompositionalLayoutDelegate: NSObject, UICollectionViewDelegate {
    var profider: any CompositionalLayoutProvider
    
    init(_ profider: any CompositionalLayoutProvider) {
        self.profider = profider
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let section = self.profider.getSection(at: indexPath)
        section.delegate?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
}
