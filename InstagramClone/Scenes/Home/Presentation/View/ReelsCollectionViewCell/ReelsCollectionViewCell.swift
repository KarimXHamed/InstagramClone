//
//  ReelsCollectionViewCell.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 24/04/2025.
//

    import UIKit

    class ReelsCollectionViewCell: UICollectionViewCell {
        
        var playerContainerView: UIView!
        private var playerView: PlayerView!
        
        private var videoURL:String?
        override init(frame: CGRect) {
            super.init(frame: frame)
            setUpPlayerContainerView()
            setUpPlayerView()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
        private func setUpPlayerContainerView() {
            playerContainerView = UIView()
            playerContainerView.backgroundColor = .black
            contentView.addSubview(playerContainerView)
            playerContainerView.translatesAutoresizingMaskIntoConstraints = false
            playerContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            playerContainerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
            playerContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
            playerContainerView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true

        }
        
        private func setUpPlayerView() {
            playerView = PlayerView()
            playerContainerView.addSubview(playerView)
            
            playerView.translatesAutoresizingMaskIntoConstraints = false
            
            playerView.centerXAnchor.constraint(equalTo: playerContainerView.centerXAnchor).isActive = true
            playerView.centerYAnchor.constraint(equalTo: playerContainerView.centerYAnchor).isActive = true
            
            playerView.widthAnchor.constraint(equalTo: playerContainerView.widthAnchor).isActive = true
            playerView.heightAnchor.constraint(equalTo: playerContainerView.heightAnchor).isActive = true
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
            print("prepare video end")
            
            
        }
        
        func cancelPreparation() {
            guard let videoURL = videoURL else {
                print("video url nil")
                return}
            guard let url = URL(string: videoURL) else {
                print("url nil")
                return }
            playerView.cancelPreparation(with:url)
        }
        
        func play() {
            print("play start")
            playerView.player?.play()
            print("play end")
            
            
        }
        
        func pause() {
            print("pause start")
            
            playerView.player?.pause()
            
            print("pause end")
            
        }
        
        func configure(model:ReelsCollectionViewCellModel){
            videoURL = model.url
            print("Configured with videoURL: \(videoURL ?? "nil")")
        }

    override func prepareForReuse() {
        super.prepareForReuse()
        //playerView.resetPlayerView()
        //videoURL = nil
        
        //cancelPreparation()
        
    }
    
}
