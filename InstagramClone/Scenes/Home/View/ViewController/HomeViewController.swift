//
//  HomeViewController.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 23/04/2025.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    var playerContainerView: UIView!
    private var playerView: PlayerView!
    private let videoURL = "https ://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    private func setupUI() {
        setupTitle()
        setUpPlayerContainerView()
        setUpPlayerView()
        playVideo()
    }
    
    private func setupTitle(){
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        label.text = "Reels"
        let leftBarButtonItem = UIBarButtonItem(customView: label)
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
    
    private func setUpPlayerContainerView() {
        playerContainerView = UIView()
        playerContainerView.backgroundColor = .black
        view.addSubview(playerContainerView)
        playerContainerView.translatesAutoresizingMaskIntoConstraints = false
        playerContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        playerContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        playerContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
            
        if #available(iOS 11.0, *) {
            playerContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            playerContainerView.topAnchor.constraint(equalTo: topLayoutGuide.topAnchor).isActive = true
        }
    }
    
    private func setUpPlayerView() {
        playerView = PlayerView()
        playerContainerView.addSubview(playerView)
            
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.leadingAnchor.constraint(equalTo: playerContainerView.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: playerContainerView.trailingAnchor).isActive = true
        playerView.heightAnchor.constraint(equalTo: playerContainerView.widthAnchor, multiplier: 16/9).isActive = true
        playerView.centerYAnchor.constraint(equalTo: playerContainerView.centerYAnchor).isActive = true
    }
    
    
    func playVideo() {
        guard let url = URL(string: videoURL) else { return }
        playerView.play(with: url)
    }

}
