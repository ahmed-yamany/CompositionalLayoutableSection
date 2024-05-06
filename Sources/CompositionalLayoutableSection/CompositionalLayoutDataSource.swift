//
//  CompositionalLayoutDataSource.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit
@available(iOS 13.0, *)
open class CompositionalLayoutDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    public weak var provider: (any CompositionalLayoutProvider)?

    public init(provider: any CompositionalLayoutProvider) {
        self.provider = provider
    }
    
    func dataSource(at indexPath: IndexPath) -> (any CompositionalLayoutableSectionDataSource)? {
        provider?.dataSource(at: indexPath)
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.provider?.compositionalLayoutSections.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource(at: .init(item: 0, section: section))?.collectionView(collectionView, numberOfItemsInSection: section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        dataSource(at: indexPath)?.collectionView(collectionView, cellForItemAt: indexPath) ?? UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        dataSource(at: indexPath)?.collectionView?(collectionView,viewForSupplementaryElementOfKind: kind,at: indexPath) ?? UICollectionReusableView()
    }
    
    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        dataSource(at: indexPath)?.collectionView?(collectionView, canMoveItemAt: indexPath) ?? false
    }
    
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        dataSource(at: sourceIndexPath)?.collectionView?(collectionView, moveItemAt: sourceIndexPath, to: destinationIndexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        dataSource(at: indexPaths[0])?.collectionView(collectionView, prefetchItemsAt: indexPaths)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        dataSource(at: indexPaths[0])?.collectionView?(collectionView, cancelPrefetchingForItemsAt: indexPaths)
    }
}
