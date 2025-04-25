//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 23/04/2025.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    
    @IBOutlet weak var reelsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    private func setupUI() {
        setupTitle()
        registerReelsCollectionViewCell()
    }
    
    private func registerReelsCollectionViewCell() {
        reelsCollectionView.delegate = self
        reelsCollectionView.dataSource = self
        reelsCollectionView.register(UINib(nibName: "ReelsCollectionViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "ReelsCollectionViewCell")
        reelsCollectionView.isPagingEnabled = true
    }
    
    private func setupTitle() {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        label.text = "Reels"
        let leftBarButtonItem = UIBarButtonItem(customView: label)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    

}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReelsCollectionViewCell", for: indexPath) as? ReelsCollectionViewCell else{
            fatalError("unable to dequeue reusable cell")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            for cell in self.reelsCollectionView.visibleCells {
                guard let indexPath = self.reelsCollectionView.indexPath(for: cell),
                      let reelCell = cell as? ReelsCollectionViewCell,
                      let attributes = self.reelsCollectionView.layoutAttributesForItem(at: indexPath) else { continue }

                let cellFrameInCollectionView = self.reelsCollectionView.convert(attributes.frame, to: self.reelsCollectionView)
                let intersection = self.reelsCollectionView.bounds.intersection(cellFrameInCollectionView)
                let visibleHeight = intersection.height
                let visibilityFraction = visibleHeight / attributes.frame.height

                print("Index: \(indexPath.item), Visibility: \(visibilityFraction)")

                if visibilityFraction > 0.5 {
                    reelCell.play()
                } else {
                    reelCell.pause()
                }
            }
        }
    }


}
