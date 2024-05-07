//
//  UICollectionViewCompositionalLayoutProvider.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit

public protocol CompositionalLayoutProvider: AnyObject {
    var compositionalLayoutSections: [CompositionalLayoutableSection] { get set }
}

extension CompositionalLayoutProvider {
    /**
     - Note: Before calling `updateCompositionalLayout(for`,
     ensure that the sections for the compositional layout have been appended to the `compositionalLayoutSections`
     property of the `CompositionalLayoutProvider`.
     Calling this method before configuring the sections may lead to unexpected behavior.
     */
    public func updateCompositionalLayout(for collectionView: UICollectionView) {
        registerCells(for: collectionView)
        registerSupplementaryViews(for: collectionView)
        updateSections(with: collectionView)
        collectionView.collectionViewLayout = collectionViewCompositionalLayout
    }
    
    private func updateSections(with collectionView: UICollectionView) {
        for index in compositionalLayoutSections.indices {
            let section = compositionalLayoutSections[index]
            section.index = index
            section.collectionView = collectionView
        }
    }
    
    private func registerCells(for collectionView: UICollectionView) {
        compositionalLayoutSections.forEach { $0.delegate?.registerCell(in: collectionView) }
    }
    
    private func registerSupplementaryViews(for collectionView: UICollectionView) {
        compositionalLayoutSections.forEach { $0.delegate?.registerSupplementaryView?(in: collectionView) }
    }
    
    private func registerDecorationViews(for layout: UICollectionViewCompositionalLayout) {
        compositionalLayoutSections.forEach { $0.delegate?.registerDecorationView?(in: layout) }
    }
    
    public func getCompositionalLayoutableSection(at indexPath: IndexPath) -> CompositionalLayoutableSection? {
        return compositionalLayoutSections[indexPath.section]
    }
    
    public func dataSource(at indexPath: IndexPath) -> (any CompositionalLayoutableSectionDataSource)? {
        getCompositionalLayoutableSection(at: indexPath)?.dataSource
    }
    
    public func prefetchDataSource(at indexPath: IndexPath) -> (any UICollectionViewDataSourcePrefetching)? {
        getCompositionalLayoutableSection(at: indexPath)?.prefetchDataSource
    }
    
    public func delegate(at indexPath: IndexPath) -> (any CompositionalLayoutableSectionDelegate)? {
        getCompositionalLayoutableSection(at: indexPath)?.delegate
    }
    
    public func sectionLayout(at indexPath: IndexPath) -> (any CompositionalLayoutableSectionLayout)? {
        getCompositionalLayoutableSection(at: indexPath)?.sectionLayout
    }
    
    public var collectionViewCompositionalLayout: UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            let indexPath = IndexPath(row: 0, section: sectionIndex)
            let section = self.sectionLayout(at: indexPath)?.sectionLayout(at: sectionIndex, layoutEnvironment: layoutEnvironment)
            return section
        }
        
        registerDecorationViews(for: layout)
        
        return layout
    }
}
