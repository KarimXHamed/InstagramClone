//
//  HomeDI.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 23/04/2025.
//
import Factory
import UIKit
import IGListKit
extension Container {
    static func homeServiceDI(navigationController:UINavigationController)->HomeViewController{
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        let dataSourceHandler = ReelsDataSource(source: viewModel)
        
        viewModel.dataSourceInjection = { [weak viewController] in
//            guard let viewController = viewController else { return }
//            let adapter = viewController.listAdapter
//            adapter?.collectionView = viewController.reelsCollectionView
//            adapter?.dataSource = dataSourceHandler
//            adapter?.delegate = dataSourceHandler
//            print("Adapter and data source set")
        }
        return viewController
    }
        var userMapper: Factory<UserMapper> {
        self { UserMapper() }
    }
    var videoFileMapper: Factory<VideoFileMapper> {
        self { VideoFileMapper() }
    }
    var videoPictureMapper: Factory<VideoPictureMapper> {
        self { VideoPictureMapper() }
    }
    
    var videoMapper: Factory<VideoMapper> {
        self { VideoMapper() }
    }
    
    var homeRemoteDataSource: Factory<HomeRemoteDataSourceProtocol>{
        self {HomeRemoteDataSource()}
    }
    
    var homeRepository: Factory<HomeRepositoryProtocol>{
        self {HomeRepository()}
    }
    
    var homeUseCase: Factory<HomeUseCaseProtocol>{
        self {HomeUseCase()}
    }
}
