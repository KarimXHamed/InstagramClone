//
//  ReelsSectionController.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 27/04/2025.
//
import Foundation
import IGListKit
class ReelsSectionController : ListSectionController {
 private var model: ReelsCollectionViewCellModel?
 
    override func sizeForItem(at index: Int) -> CGSize {

        guard let collectionContext = collectionContext else {
            return .zero
        }

        let width = collectionContext.containerSize.width
        let height = collectionContext.containerSize.height

        
        return CGSize(width: width, height: height)
    }

    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let collectionContext = collectionContext,
              let model = model else {
            fatalError("CollectionContext or model is missing")
        }
        
        guard let cell = collectionContext.dequeueReusableCell(
                of: ReelsCollectionViewCell.self,
                for: self,
                at: index
        ) as? ReelsCollectionViewCell else {
            fatalError("Could not dequeue ReelsCollectionViewCell")
        }
        
        cell.configure(model: model)
        return cell
    }

    override func didUpdate(to object: Any) {
        self.model = object as? ReelsCollectionViewCellModel

    }
    
    override func didSelectItem(at index: Int) {
        // Optional: handle tap
    }

}
