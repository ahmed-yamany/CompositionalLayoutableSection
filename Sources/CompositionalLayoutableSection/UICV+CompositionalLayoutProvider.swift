//
//  UICollectionView+SectionType.swift
//  iCinema
//
//  Created by Ahmed Yamany on 06/02/2023.
//

import UIKit

@available(iOS 13.0, *)
extension UICollectionView {
    /**
     Updates the collection view's compositional layout using the provided `CompositionalLayoutProvider`.

     This method takes a `CompositionalLayoutProvider` as a parameter
     and uses it to update the collection view's compositional layout.
     It also handles the registration of cells and supplementary views defined by the `CompositionalLayoutProvider`.

     - Parameter provider: The `CompositionalLayoutProvider` object
     that configures the layout and registers cells and supplementary views.

     - Note: Before calling `updateCollectionViewCompositionalLayout(with:)`,
     ensure that the sections for the compositional layout have been appended to the `compositionalLayoutSections`
     property of the `CompositionalLayoutProvider`.
     Calling this method before configuring the sections may lead to unexpected behavior.
     */
    public func updateCollectionViewCompositionalLayout(for provider: CompositionalLayoutProvider) {
        provider.registerCells(for: self)
        provider.registerSupplementaryViews(for: self)
        collectionViewLayout = provider.collectionViewCompositionalLayout
    }
}
