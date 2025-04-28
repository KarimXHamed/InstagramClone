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
        print("start size for item")

        guard let collectionContext = collectionContext else {
            print("failed size for item")
            return .zero
        }

        let width = collectionContext.containerSize.width
        let height = collectionContext.containerSize.height

        print("Cell size for item at index \(index): width = \(width), height = \(height)")
        
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
        
        print("cellForItem at index \(index): \(model)")
        cell.configure(model: model) 
        return cell
    }

    override func didUpdate(to object: Any) {
        self.model = object as? ReelsCollectionViewCellModel
        print("didUpdate model to: \(model?.url)")  // Debugging when the model is updated

    }
    
    override func didSelectItem(at index: Int) {
        // Optional: handle tap
    }

}
