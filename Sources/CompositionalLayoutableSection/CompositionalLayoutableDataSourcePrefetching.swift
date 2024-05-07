//
//  CompositionalLayoutableDataSourcePrefetching.swift
//
//
//  Created by Ahmed Yamany on 07/05/2024.
//

import UIKit

open class CompositionalLayoutableDataSourcePrefetching: NSObject, UICollectionViewDataSourcePrefetching {
    public weak var provider: (any CompositionalLayoutProvider)?
    
    public init(provider: any CompositionalLayoutProvider) {
        self.provider = provider
    }
    
    func prefetchDataSource(at indexPath: IndexPath) -> (any UICollectionViewDataSourcePrefetching)? {
        provider?.prefetchDataSource(at: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let firstIndex = indexPaths[safe: 0] else {
            return
        }
        prefetchDataSource(at: firstIndex)?.collectionView(collectionView, prefetchItemsAt: indexPaths)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        guard let firstIndex = indexPaths[safe: 0] else {
            return
        }
        prefetchDataSource(at: firstIndex)?.collectionView?(collectionView, cancelPrefetchingForItemsAt: indexPaths)
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
