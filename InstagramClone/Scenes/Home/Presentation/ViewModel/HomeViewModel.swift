//
//  HomeViewModel.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Factory
import Combine
import IGListKit
class HomeViewModel:BaseViewModel,HomeViewModelProtocol {
    
    //MARK: -injection properties
    @Injected(\.homeUseCase) private var useCase: HomeUseCaseProtocol
    
    //MARK: -variables
    var dataSourceInjection: (() -> Void)?
    var reels:[ReelsCollectionViewCellModel]?

    
    //MARK: -lifeCycle
    func viewWillAppear() {
        dataSourceInjection?()

        let request = ReelsRequest()
        useCase.execute(request: request) { [weak self] result in
            switch result {
            case .success(let reels):
                self?.onSuccess(success: reels)
            case .failure(let failure):
                print(failure)
                
            }
            
        }
    }
    
    private func onSuccess(success:Reels){
        let mappedReels = mapReels(reels: success)
        reels = mappedReels
        reloadData = true
    }
        private func mapReels(reels: Reels) -> [ReelsCollectionViewCellModel] {
            return reels.videos.compactMap { video in
                guard let videoLink = video.videoFiles.first?.link else { return nil }
                return ReelsCollectionViewCellModel(
                    url:videoLink ,
                    thumbnail: video.image,
                    userName: video.user.name
                )
            }
        }
}
extension HomeViewModel:ReelsCollectionViewDelegate {
    func numberOfItems() -> Int {
        guard let reels = reels else {
            return 0
        }
        return reels.count
    }
    
    func models()->[ListDiffable]
{
        guard let reels = reels else {
            
            return []
        }
        return reels
    }
    
 
}
