//
//  ReelsSectionController.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 27/04/2025.
//
import Foundation
import IGListKit
class ReelsSectionController : ListSectionController, ListWorkingRangeDelegate {
 private var model: ReelsCollectionViewCellModel?
    
    override init() {
        super.init()
        self.workingRangeDelegate = self
    }

   
    override func sizeForItem(at index: Int) -> CGSize {
        guard let collectionContext = collectionContext else { return .zero }
        print("sizeForItem: \(collectionContext.containerSize.width) x \(collectionContext.containerSize.height)") 

        return CGSize(width: collectionContext.containerSize.width,
                      height: collectionContext.containerSize.height)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let collectionContext = collectionContext,
              let model = model,
              let cell = collectionContext.dequeueReusableCell(of: ReelsCollectionViewCell.self, for: self, at: index) as? ReelsCollectionViewCell else {
            fatalError()
        }
        print("cellForItem at index \(index): \(model)")  // Debugging the cell being configured with the model

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
    // MARK: - Working Range Delegate Methods

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerWillEnterWorkingRange sectionController: ListSectionController) {
        print("Will enter working range")
        // Access the cell for item at index
        if let videoCell = collectionContext?.cellForItem(at: 0, sectionController: sectionController) as? ReelsCollectionViewCell {
            print("cast match")
            videoCell.prepareVideo()  // Start video
            videoCell.play()          // Play video
        }
    }

//    // Triggered when the cell goes out of the visible range
        func listAdapter(_ listAdapter: ListAdapter, sectionControllerDidExitWorkingRange sectionController: ListSectionController) {
        print("Did exit working range")
        // Access the cell for item at index
            if let videoCell = collectionContext?.cellForItem(at: 0, sectionController: sectionController) as? ReelsCollectionViewCell {
                print("cast match")

            videoCell.pause()  // Pause video
        }
    }
}
