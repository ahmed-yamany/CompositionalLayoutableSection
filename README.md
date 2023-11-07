# CompositionalLayoutableSection


https://github.com/ahmed-yamany/CompositionalLayoutableSection/assets/58072774/b2be01ab-008b-4fc1-89a2-b9cdc4a1847e

CompositionalLayoutableSection is a Swift library that simplifies the implementation of compositional layouts for UICollectionViews on iOS 13.0 and later. This library introduces a set of protocols and a base class to help you create organized and abstracted sections for your collection view.

It allows for better code organization and reusability, making it easier to maintain and switch between different sections within the same collection view.


## Table of Contents
- Introduction
- Protocols
- CompositionalLayoutableSection
- Usage

## Introduction
UICollectionViews with compositional layouts offer a flexible and powerful way to create complex UI interfaces. CompositionalLayoutableSection provides a convenient framework to work with compositional layouts in a more structured manner.

## Protocols
CompositionalLayoutableSection introduces three protocols:
### CompositionalLayoutableSectionDataSource

```swift
public protocol CompositionalLayoutableSectionDataSource: UICollectionViewDataSource {
    associatedtype ItemsType
    var items: [ItemsType] { get set }
    
    func update(_ collectionView: UICollectionView, withItems items: [ItemsType])
}
```
This protocol defines the data source for a section in the compositional layout. It requires you to specify the data type for the section's items and allows you to update the items and trigger a collection view data reload.

### CompositionalLayoutableSectionLayout
```swift
@available(iOS 13.0, *)
@objc public protocol CompositionalLayoutableSectionLayout {
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection
}
```
This protocol defines the layout for a section. It enables you to return a NSCollectionLayoutSection based on the index and layout environment.

### CompositionalLayoutableSectionDelegate
```swift
@available(iOS 13.0, *)
@objc public protocol CompositionalLayoutableSectionDelegate: UICollectionViewDelegate {
    @objc func registerCell(_ collectionView: UICollectionView)
    @objc optional func registerSupplementaryView(_ collectionView: UICollectionView)
    @objc optional func registerDecorationView(_ layout: UICollectionViewCompositionalLayout)
}
```
### CompositionalLayoutProvider
```swift
@available(iOS 13.0, *)
public protocol CompositionalLayoutProvider {
    var compositionalLayoutSections: [CompositionalLayoutableSection] { get set }
}
```
The `CompositionalLayoutProvider` protocol defines the requirements for providing Sections data for the `UICollectionView`


## CompositionalLayoutableSection
CompositionalLayoutableSection is an open class that acts as a container for a section's data source, layout, and delegate. You can create objects that inherit from this class to define the properties for each section in your collection view.

## Usage
Here's an example of how you can use CompositionalLayoutableSection to manage sections in your UICollectionView:

```swift
import UIKit
import CompositionalLayoutableSection

// A custom section for displaying Products in a collection view.
class ProductsCollectionViewSection: CompositionalLayoutableSection {
    typealias ItemsType = Product
    typealias CellType = ProductCollectionViewCell
    //
    var items: [ItemsType] = []
    override init() {
        super.init()
        delegate = self
        dataSource = self
        layout = self
    }
}
// MARK: - Products CollectionView Section Data Source
//
extension ProductsCollectionViewSection: CompositionalLayoutableSectionDataSource {
    ///
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    /// cell For Item At
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(CellType.self, for: indexPath)
        let product = items[indexPath.item]
        cell.configure(with: product)
        return cell
    }
}
// MARK: - Products CollectionView Section Layout
extension ProductsCollectionViewSection: CompositionalLayoutableSectionLayout {
    var spacing: CGFloat { 20 } // The spacing between items in the section.
    var width: CGFloat { 156 } // The width of each item in the section.
    var height: CGFloat { 242 } // The height of each item in the section.
    /// - Returns: The layout for an item within the group.
    var itemLayoutInGroup: NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        return item
    }
    /// - Returns: The layout for a group within the section.
    var groupLayoutInSection: NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [itemLayoutInGroup])
        return group
    }
    /// Defines the layout for the entire section, including groups and supplementary views.
    func sectionLayout(at index: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: groupLayoutInSection)
        //
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: spacing, trailing: spacing)
        section.interGroupSpacing = spacing
        //
        return section
    }
}
// MARK: - Products CollectionView Section Delegate
extension ProductsCollectionViewSection: CompositionalLayoutableSectionDelegate {
    /// Registers the cell type with the given collection view.
    func registerCell(_ collectionView: UICollectionView) {
        collectionView.registerFromNib(CellType.self)
    }
}
```

```swift
class MyViewController: UICollectionViewController, CompositionalLayoutProvider {
    var compositionalLayoutSections: [CompositionalLayoutableSection] = []
    //
    private(set) lazy var delegate = CompositionalLayoutDelegate(provider: self)
    private(set) lazy var datasource = CompositionalLayoutDataSource(provider: self)
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = delegate
        collectionView.dataSource = datasource
        // Create and configure a section
        let section = ProductsCollectionViewSection()
        let items = [Product(), Product(), Product()]
        section.update(collectionView, withItems: items)
        // Add the section to the compositionalLayoutSections
        compositionalLayoutSections.append(section)
        //
       // this must be called after adding all sections to compositionalLayoutSections
       collectionView.updateCollectionViewCompositionalLayout(for: self)
    }
}
```

## Requirements
    iOS 13.0 or later
    Swift 5.0 or later
## Author
[Ahmed Yamany](https://www.linkedin.com/in/ahmed-yamany/) 

## Other Resources
### Xcode file Template for CompositionalLayoutableSection
[https://github.com/ahmed-yamany/Xcode-File-Templates](https://github.com/ahmed-yamany/Xcode-File-Templates)

### Mega Mall 
personal project that video recorded from 
[https://github.com/ahmed-yamany/Mega-Mall](https://github.com/ahmed-yamany/Mega-Mall)
