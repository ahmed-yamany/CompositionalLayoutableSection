//
//  CollectionViewModelSectionType.swift
//  iCinema
//
//  Created by Ahmed Yamany on 05/02/2023.
//

import UIKit

protocol CompositionalLayoutableSectionDataSource: UICollectionViewDataSource {
    /// A generic type representing the data type for the items in the section.
    associatedtype ResposeType
    
    /// An array of items for the section.
    var items: [ResposeType] { get set }
    
    /// Items count in the section.
    /// Why not using items.count?
    /// because XCode gives me error build failed with a nonzero exit code so this was the solve to ignore this bug
    var itemsCount: Int { get set }

}

@available(iOS 13.0, *)
protocol CompositionalLayoutableSectionLayout {
    /// Returns the layout for an item in the section.
    func itemLayoutInGroup() -> NSCollectionLayoutItem
    
    /// Returns the layout for the group of items in the section.
    func groupLayoutInSection() -> NSCollectionLayoutGroup
    
    /// Returns the layout for the section.
    func sectionLayout() -> NSCollectionLayoutSection
    
}

@objc protocol CompositionalLayoutableSectionDelegate: UICollectionViewDelegate {
    /// Registers the cell type to be used for the items in the section.
    @objc func registerCell(_ collectionView: UICollectionView)
    
    /// Registers the supplementary view type to be used in the section.
    @objc optional func registerSupplementaryView(_ collectionView: UICollectionView)
    
    /// updates items and should reloads collection view data
    @objc func updateItems(_ collectionView: UICollectionView)
}


/*
 - This class defines a three optional properties that hold objects
   conforming to the three protocols a section in the compositional layout should implement

 - Using this can lead to better organization and abstraction of your code,
   as well as making it easier to reuse and maintain.
 
 - You can create multiple objects Inherets from this class
   and switch between them to show different sections in the same collection view,
 */
@available(iOS 13.0, *)
class CompositionalLayoutableSection: NSObject {
    
    var dataSource: (any CompositionalLayoutableSectionDataSource)? = nil
    var layout: (any CompositionalLayoutableSectionLayout)? = nil
    var delegate: (any CompositionalLayoutableSectionDelegate)? = nil
    
}


