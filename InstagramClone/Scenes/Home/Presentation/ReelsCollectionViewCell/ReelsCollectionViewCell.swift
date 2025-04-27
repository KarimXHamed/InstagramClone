//
//  ReelsCollectionViewCell.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 24/04/2025.
//

import UIKit

class ReelsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var playerContainerView: UIView!
    private let videoURL = "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4"
    private var playerView: PlayerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpPlayerView()
        playVideo()
        playerContainerView.backgroundColor = .black
    }
    private func setUpPlayerView() {
        print("setUpPlayerView started")
        playerView = PlayerView()
        playerContainerView.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.leadingAnchor.constraint(equalTo: playerContainerView.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: playerContainerView.trailingAnchor).isActive = true
        playerView.heightAnchor.constraint(equalTo: playerContainerView.widthAnchor).isActive = true
        playerView.centerYAnchor.constraint(equalTo: playerContainerView.centerYAnchor).isActive = true
        print("setUpPlayerView ended")

    }
    
    
    func playVideo() {
        print("playvideo started")

        guard let url = URL(string: videoURL) else { return }
        playerView.prepareToPlay(with: url)
        print("playvideo ended")

    }
    func play() {
        print("play started")

        playerView.player?.play()
        print("play ended")

    }
    
    func pause() {
        print("pause started")

        playerView.player?.pause()
        print("pause ended")

    }

}
