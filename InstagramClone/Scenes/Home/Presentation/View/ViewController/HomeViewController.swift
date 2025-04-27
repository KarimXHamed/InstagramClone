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
    }
    //MARK: -SetupUI
    private func setupUI() {
        viewModel.viewWillAppear()
        setupTitle()
        registerReelsCollectionViewCell()
        setupIGListKit()
    }
    
    private func setupIGListKit() {
        let updater = ListAdapterUpdater()
        listAdapter = ListAdapter(updater: updater, viewController: self,workingRangeSize: 1)
                    listAdapter.collectionView = self.reelsCollectionView
                    listAdapter.dataSource = self
                    listAdapter.delegate = self
                    print("Adapter and data source set")
    }
    
    private func registerReelsCollectionViewCell() {
        reelsCollectionView.register(UINib(nibName: "ReelsCollectionViewCell", bundle: nil),
                                     forCellWithReuseIdentifier: "ReelsCollectionViewCell")
        reelsCollectionView.isPagingEnabled = true
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
extension HomeViewController: ListAdapterDataSource , ListAdapterDelegate {
    func listAdapter(_ listAdapter: ListAdapter, willDisplay object: Any, at index: Int) {
        print("will display:\(object)")
        if let videoCell = object as? ReelsCollectionViewCell {
            print("success cast")
            videoCell.prepareVideo()
            videoCell.play()
             }
    }
    
    func listAdapter(_ listAdapter: ListAdapter, didEndDisplaying object: Any, at index: Int) {
        print("end display:\(object)")

    }
    
    // MARK: - ListAdapterDelegate Methods

    
    // MARK: - IGListKit DataSource Methods
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        print("Objects for listAdapter: \(viewModel.models())")  // Debugging the data being provided to IGListKit
        
        return viewModel.models()
    }
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
                print("Section controller requested for object: \(object)")  // Debugging the request for section controllers
                return ReelsSectionController()
            }
        
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
                return nil
            }
        
    }


