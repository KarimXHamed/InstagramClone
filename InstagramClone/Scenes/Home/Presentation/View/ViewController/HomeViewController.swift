//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 23/04/2025.
//

import UIKit
import Combine
import IGListKit
class HomeViewController: BaseViewController {
    //MARK: -Outlets
    @IBOutlet weak var reelsCollectionView: UICollectionView!
    //MARK: -variables
    private var viewModel:HomeViewModelProtocol
    var listAdapter: ListAdapter!
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
        bindViewModel()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.viewWillAppear()
        setupScrollViewDelegate()

    }
    
    
    //MARK: -SetupUI
    private func setupUI() {
        setupCollectionView()
        setupTitle()
        registerReelsCollectionViewCell()
        setupNavigationBar()
        
    }
    
    private func setupCollectionView(){
                DispatchQueue.main.async{
                    self.reelsCollectionView.contentOffset.y=0
                    self.reelsCollectionView.contentOffset = .zero
                }
    }
    
    private func setupScrollViewDelegate() {

        listAdapter.scrollViewDelegate = self
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

    }
    
    private func registerReelsCollectionViewCell() {
        reelsCollectionView.register(UINib(nibName: "ReelsCollectionViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "ReelsCollectionViewCell")
        reelsCollectionView.isPagingEnabled = true
        
    }
    private func playFirstVideo() {
        
        DispatchQueue.main.async{
            let firstIndexPath = IndexPath(item: 0, section: 0)
            
            guard let firstCell = self.reelsCollectionView.cellForItem(at: firstIndexPath) as? ReelsCollectionViewCell else{
                return
            }
            firstCell.prepareVideo()
        }
        
        
    }
    
    //MARK: -Bind View Model
    func bindViewModel(){
        viewModel.shouldReloadPublisher
            .receive(on: DispatchQueue.main)
            .sink{ [weak self] _ in
                self?.onSuccessReels()
                
            }
            .store(in: &cancellables)
    }
    
    private func onSuccessReels() {
        print("will update data")
        listAdapter.performUpdates(animated: true)
        playFirstVideo()
        
        
        
    }
    
    private func setupTitle() {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .white
        label.text = "Reels"
        let leftBarButtonItem = UIBarButtonItem(customView: label)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    
    
}
extension HomeViewController: UICollectionViewDelegate  {
    // MARK: - Scroll view delegate Methods
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
                    reelCell.prepareVideo()
                } else {
                    reelCell.cancelPreparation()
                }
            }
        }
    }
    
    
}


