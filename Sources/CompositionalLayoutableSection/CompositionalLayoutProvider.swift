//
//  UICollectionViewCompositionalLayoutProvider.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit

@available(iOS 13.0, *)
public protocol CompositionalLayoutProvider: AnyObject {
    var compositionalLayoutSections: [CompositionalLayoutableSection] { get set }
}

@available(iOS 13.0, *)
extension CompositionalLayoutProvider {
    public func registerCells(for collectionView: UICollectionView) {
        compositionalLayoutSections.forEach { $0.delegate?.registerCell(in: collectionView) }
    }

    public func registerSupplementaryViews(for collectionView: UICollectionView) {
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
    
    public func delegate(at indexPath: IndexPath) -> (any CompositionalLayoutableSectionDelegate)? {
        getCompositionalLayoutableSection(at: indexPath)?.delegate
    }
    
    public func layout(at indexPath: IndexPath) -> (any CompositionalLayoutableSectionLayout)? {
        getCompositionalLayoutableSection(at: indexPath)?.sectionLayout
    }
    
    public var collectionViewCompositionalLayout: UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] sectionIndex, layoutEnvironment in
            guard let self = self else { return nil }
            let indexPath = IndexPath(row: 0, section: sectionIndex)
            let section = self.layout(at: indexPath)?.sectionLayout(at: sectionIndex, layoutEnvironment: layoutEnvironment)
            return section
        }
        
        registerDecorationViews(for: layout)
        
        return layout
    }
}
