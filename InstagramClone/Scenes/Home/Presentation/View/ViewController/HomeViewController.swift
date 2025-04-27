//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 23/04/2025.
//

import UIKit
import Combine
import IGListKit
class HomeViewController: UIViewController {
    //MARK: -Outlets
@IBOutlet weak var reelsCollectionView: UICollectionView!
    //MARK: -variables
        private var viewModel:HomeViewModelProtocol
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
  
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()
    }
    //MARK: -SetupUI
    private func setupUI() {
        setupTitle()
        registerReelsCollectionViewCell()
        //setupIGListKit()
    }
    
    private func setupIGListKit() {
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self,workingRangeSize: 1)
//        adapter.collectionView = reelsCollectionView
//        adapter.dataSource = self
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
//MARK: -Collection view cell functions (will be removed)
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
