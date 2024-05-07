//
//  CompositionalLayoutDelegate.swift
//  iCinema
//
//  Created by Ahmed Yamany on 07/04/2023.
//

import UIKit

@available(iOS 13.0, *)
open class CompositionalLayoutDelegate: NSObject, UICollectionViewDelegate {
    public weak var provider: (any CompositionalLayoutProvider)?
    
    public init(provider: any CompositionalLayoutProvider) {
        self.provider = provider
    }
    
    private func delegate(at indexPath: IndexPath) -> UICompositionalLayoutableSectionDelegate? {
        provider?.delegate(at: indexPath)
    }
    
    private func delegates() -> [UICompositionalLayoutableSectionDelegate?] {
        provider?.compositionalLayoutSections.map { $0.delegate } ?? []
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        delegate(at: indexPath)?.collectionView?(collectionView, shouldHighlightItemAt: indexPath) ?? true
    }
    
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        delegate(at: indexPath)?.collectionView?(collectionView, didHighlightItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        delegate(at: indexPath)?.collectionView?(collectionView, didUnhighlightItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        delegate(at: indexPath)?.collectionView?(collectionView, shouldSelectItemAt: indexPath) ?? true
    }
    
    public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        delegate(at: indexPath)?.collectionView?(collectionView, shouldDeselectItemAt: indexPath) ?? true
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate(at: indexPath)?.collectionView?(collectionView, didSelectItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        delegate(at: indexPath)?.collectionView?(collectionView, didDeselectItemAt: indexPath)
    }
    @available(iOS 16.0, *)
    public func collectionView(_ collectionView: UICollectionView, canPerformPrimaryActionForItemAt indexPath: IndexPath) -> Bool { 
        delegate(at: indexPath)?.collectionView?(collectionView, canPerformPrimaryActionForItemAt: indexPath) ?? true
    }
    
    @available(iOS 16.0, *)
    public func collectionView(_ collectionView: UICollectionView, performPrimaryActionForItemAt indexPath: IndexPath) { 
        delegate(at: indexPath)?.collectionView?(collectionView, performPrimaryActionForItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegate(at: indexPath)?.collectionView?(collectionView, willDisplay: cell, forItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        delegate(at: indexPath)?.collectionView?(collectionView, willDisplaySupplementaryView: view, forElementKind: elementKind, at: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        delegate(at: indexPath)?.collectionView?(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        delegate(at: indexPath)?.collectionView?(collectionView, didEndDisplayingSupplementaryView: view, forElementOfKind: elementKind, at: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        delegate(at: indexPath)?.collectionView?(collectionView, contextMenuConfigurationForItemAt: indexPath, point: point)
    }
    
    @available(iOS 16.0, *)
    public func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemsAt indexPaths: [IndexPath], point: CGPoint) -> UIContextMenuConfiguration? {
        guard let indexPath = indexPaths.first else { return nil }
        return delegate(at: indexPath)?.collectionView?(collectionView, contextMenuConfigurationForItemsAt: indexPaths, point: point)
    }
    
    @available(iOS 16.0, *)
    public func collectionView(_ collectionView: UICollectionView, contextMenuConfiguration configuration: UIContextMenuConfiguration, dismissalPreviewForItemAt indexPath: IndexPath) -> UITargetedPreview? {
        delegate(at: indexPath)?.collectionView?(collectionView, contextMenuConfiguration: configuration, dismissalPreviewForItemAt: indexPath)
    }
    
    @available(iOS 16.0, *)
    public func collectionView(_ collectionView: UICollectionView, contextMenuConfiguration configuration: UIContextMenuConfiguration, highlightPreviewForItemAt indexPath: IndexPath) -> UITargetedPreview? {
        delegate(at: indexPath)?.collectionView?(collectionView, contextMenuConfiguration: configuration, highlightPreviewForItemAt: indexPath)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegates().forEach { $0?.scrollViewDidScroll?(scrollView) }
    }

    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        delegates().forEach { $0?.scrollViewDidZoom?(scrollView) }
    }

    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        delegates().forEach { $0?.scrollViewWillBeginDragging?(scrollView) }
    }

    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        delegates().forEach { $0?.scrollViewWillEndDragging?(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset) }
    }

    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        delegates().forEach { $0?.scrollViewDidEndDragging?(scrollView, willDecelerate: decelerate) }

    }

    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        delegates().forEach { $0?.scrollViewWillBeginDecelerating?(scrollView) }
    }

    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegates().forEach { $0?.scrollViewDidEndDecelerating?(scrollView) }
    }

    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        delegates().forEach { $0?.scrollViewDidEndScrollingAnimation?(scrollView) }
    }
    
    public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        delegates().forEach { $0?.scrollViewWillBeginZooming?(scrollView, with: view) }
    }

    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        delegates().forEach { $0?.scrollViewDidEndZooming?(scrollView, with: view, atScale: scale) }
    }
    
    public func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        delegates().forEach { $0?.scrollViewDidScrollToTop?(scrollView) }
    }
     
    public func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        delegates().forEach { $0?.scrollViewDidChangeAdjustedContentInset?(scrollView) }
    }
}
