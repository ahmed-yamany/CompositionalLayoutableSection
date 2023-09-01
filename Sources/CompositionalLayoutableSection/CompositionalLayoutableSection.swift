//
//  CollectionViewModelSectionType.swift
//  iCinema
//
//  Created by Ahmed Yamany on 05/02/2023.
//

import UIKit

public protocol CompositionalLayoutableSectionDataSource: UICollectionViewDataSource {
    /// A generic type representing the data type for the items in the section.
    associatedtype ResposeType
    /// An array of items for the section.
    var items: [ResposeType] { get set }
    /// updates items and should reloads collection view data
    func update(_ collectionView: UICollectionView, withItems items: [ResposeType])
}

@available(iOS 13.0, *)
public protocol CompositionalLayoutableSectionLayout {
    /// Returns the layout for an item in the section.
    func itemLayoutInGroup() -> NSCollectionLayoutItem
    /// Returns the layout for the group of items in the section.
    func groupLayoutInSection() -> NSCollectionLayoutGroup
    /// Returns the layout for the section.
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection
}

@objc public protocol CompositionalLayoutableSectionDelegate: UICollectionViewDelegate {
    /// Registers the cell type to be used for the items in the section.
    @objc func registerCell(_ collectionView: UICollectionView)
    /// Registers the supplementary view type to be used in the section.
    @objc optional func registerSupplementaryView(_ collectionView: UICollectionView)
}

/*
 - This class defines a three optional properties that hold objects
   conforming to the three protocols a section in the compositional layout should implement

 - Using this can lead to better organization and abstraction of your code,
   as well as making it easier to reuse and maintain.
 
 - You can create multiple objects Inherets from this class
   and switch between them to show different sections in the same collection view,
 */
// swiftlint:disable all
@available(iOS 13.0, *)
open class CompositionalLayoutableSection: NSObject {
    open var dataSource: (any CompositionalLayoutableSectionDataSource)? = nil
    open var layout: (any CompositionalLayoutableSectionLayout)? = nil
    open var delegate: (any CompositionalLayoutableSectionDelegate)? = nil
}
// swiftlint:enable all
