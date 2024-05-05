//
//  CollectionViewModelSectionType.swift
//  iCinema
//
//  Created by Ahmed Yamany on 05/02/2023.
//

import UIKit

public protocol CompositionalLayoutableSectionDataSource: UICollectionViewDataSource {
    associatedtype ItemsType

    var items: [ItemsType] { get set }
}

public protocol CompositionalLayoutableSectionLayout: AnyObject {
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection
}

@objc public protocol CompositionalLayoutableSectionDelegate: UICollectionViewDelegate {
    @objc func registerCell(in collectionView: UICollectionView)
    @objc optional func registerSupplementaryView(in collectionView: UICollectionView)
    @objc optional func registerDecorationView(in layout: UICollectionViewCompositionalLayout)
}

/*
 - This class defines a three optional properties that hold objects
   conforming to the three protocols a section in the compositional layout should implement

 - Using this can lead to better organization and abstraction of your code,
   as well as making it easier to reuse and maintain.

 - You can create multiple objects Inherets from this class
   and switch between them to show different sections in the same collection view,
 */
open class CompositionalLayoutableSection: NSObject {
    open weak var dataSource: (any CompositionalLayoutableSectionDataSource)?
    open weak var sectionLayout: (any CompositionalLayoutableSectionLayout)?
    open weak var delegate: (any CompositionalLayoutableSectionDelegate)?
    public weak var collectionView: UICollectionView!
    public var index: Int!
}
