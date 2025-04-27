//
//  ReelsCollectionViewCell.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 24/04/2025.
//

import UIKit

class ReelsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var playerContainerView: UIView!
    private var videoURL:String?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareVideo()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awake from nib start")
        playerContainerView.backgroundColor = .black
        print("awake from nib end")

    }
    

    
    private func setUpPlayerView() {
        playerContainerView.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        playerView.leadingAnchor.constraint(equalTo: playerContainerView.leadingAnchor).isActive = true
        playerView.trailingAnchor.constraint(equalTo: playerContainerView.trailingAnchor).isActive = true
        playerView.heightAnchor.constraint(equalTo: playerContainerView.widthAnchor).isActive = true
        playerView.centerYAnchor.constraint(equalTo: playerContainerView.centerYAnchor).isActive = true

    }
    
    
    func prepareVideo() {
        print("prepare video start")

        guard let videoURL = videoURL else {
            print("video url nil")
            return}
        guard let url = URL(string: videoURL) else {
            print("url nil")

            return }
        playerView.prepareToPlay(with: url)
        play()
        print("prepare video end")


    }
    func play() {
print("play start")
        playerView.player?.play()
        print("play end")


    }
    
    func pause() {

        playerView.player?.pause()

    }
    
    func configure(model:ReelsCollectionViewCellModel){
        videoURL = model.url
          print("Configured with videoURL: \(videoURL ?? "nil")")
    }

}
