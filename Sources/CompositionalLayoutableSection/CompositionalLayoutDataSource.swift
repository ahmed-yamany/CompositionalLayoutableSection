//
//  CompositionalLayoutDataSource.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit

public protocol CompositionalLayoutDataSourceConfiguration: AnyObject {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
}

open class CompositionalLayoutDataSource: NSObject, UICollectionViewDataSource {
    
    public weak var provider: (any CompositionalLayoutProvider)?
    public weak var configuration: (any CompositionalLayoutDataSourceConfiguration)?
    
    public init(provider: any CompositionalLayoutProvider, configuration: (any CompositionalLayoutDataSourceConfiguration)? = nil) {
        self.provider = provider
    }
    
    func dataSource(at indexPath: IndexPath) -> (any UICompositionalLayoutableSectionDataSource)? {
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
        if indexPath.item == 9223372036854775807, let configuration = configuration {
            return configuration.collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        } else {
            return dataSource(at: indexPath)?.collectionView?(collectionView,viewForSupplementaryElementOfKind: kind,at: indexPath) ?? UICollectionReusableView()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        dataSource(at: indexPath)?.collectionView?(collectionView, canMoveItemAt: indexPath) ?? false
    }
    
    public func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        dataSource(at: sourceIndexPath)?.collectionView?(collectionView, moveItemAt: sourceIndexPath, to: destinationIndexPath)
    }
}
