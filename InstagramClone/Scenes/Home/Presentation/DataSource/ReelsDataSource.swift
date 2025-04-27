//
//  ReelsDataSource.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Foundation
import UIKit
import IGListKit
class ReelsDataSource:NSObject {
    private weak var source: ReelsCollectionViewDelegate?
    init(source: ReelsCollectionViewDelegate?) {
        self.source = source
    }
    
}

extension ReelsDataSource: ListAdapterDataSource , ListAdapterDelegate {
    func listAdapter(_ listAdapter: ListAdapter, willDisplay object: Any, at index: Int) {
        return
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying object: Any, at index: Int) {
        return
    }
    
    
    //MARK: -IGListKit functions
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        print("Objects for listAdapter: \(source?.models() ?? [])")  // Debugging the data being provided to IGListKit

        return source?.models() ?? [] }
        func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
            print("Section controller requested for object: \(object)")  // Debugging the request for section controllers
            return ReelsSectionController()
        }
    
        func emptyView(for listAdapter: ListAdapter) -> UIView? {
            return nil
        }
    
}
