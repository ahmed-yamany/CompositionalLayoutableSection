//
//  CompositionalLayoutDataSource.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit


@available(iOS 13.0, *)
open class CompositionalLayoutDataSource: NSObject, UICollectionViewDataSource {
    
    open var profider: any CompositionalLayoutProvider
    
    public init(_ profider: any CompositionalLayoutProvider) {
        self.profider = profider
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.profider.compositionalLayoutSections.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let compositionalSection = self.profider.getSection(at: IndexPath(item: 0, section: section))
        return compositionalSection.dataSource?.itemsCount ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = self.profider.getSection(at: indexPath)
        return section.dataSource?.collectionView(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = self.profider.getSection(at: indexPath)
        return section.dataSource?.collectionView?(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath) ?? UICollectionReusableView()
    }
    
}

