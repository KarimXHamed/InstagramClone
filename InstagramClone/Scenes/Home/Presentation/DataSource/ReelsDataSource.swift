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

extension ReelsDataSource: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return source?.models() ?? []
    }
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return ReelsSectionController()
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
    
}
