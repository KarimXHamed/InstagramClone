//
//  PlayerView.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 24/04/2025.
//

import UIKit
import AVFoundation

class PlayerView: UIView {
    private var isPreparing = false
    private var isCancelled = false
    private var alreadyPlayed = false
    private static var playerTimeCache: [String: CMTime] = [:]
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    private var playerItemContext = 0
    
    private var playerItem: AVPlayerItem?
    
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    private func setUpAsset(
        with url: URL,
        completion: @escaping (Result<AVAsset, Error>) -> Void
    ) {
        if #available(iOS 16.0, *) {
            Task {
                do {
                    let asset = AVURLAsset(url: url)
                    let isPlayable = try await asset.load(.isPlayable)
                    
                    guard isPlayable else {
                        throw NSError(domain: "AVAssetError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Asset is not playable"])
                    }
                    
                    completion(.success(asset))
                } catch {
                    completion(.failure(error))
                }
            }
            
        } else {
            let asset = AVURLAsset(url: url)
            asset.loadValuesAsynchronously(forKeys: ["playable"]) {
                var error: NSError? = nil
                let status = asset.statusOfValue(forKey: "playable", error: &error)
                switch status {
                case .loaded:
                    completion(.success(asset))
                case .failed, .cancelled:
                    completion(.failure(error ?? NSError(domain: "AVAssetError", code: 0)))
                default:
                    completion(.failure(NSError(domain: "AVAssetError", code: 1)))
                }
            }
        }
    }
    private func setUpPlayerItem(with asset: AVAsset) {
        // Clean old player item if it exists
        if let oldPlayerItem = playerItem {
            oldPlayerItem.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: oldPlayerItem)
        }

        player?.pause()
        player = nil
        playerItem = nil

        // Create new AVPlayerItem
        let newItem = AVPlayerItem(asset: asset)
        playerItem = newItem

        // Observe status change
        newItem.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.old, .new], context: &playerItemContext)

        // Observe end of playback to loop
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: newItem
        )

        // Set up player on main thread
        DispatchQueue.main.async { [weak self] in
            self?.player = AVPlayer(playerItem: newItem)
        }
    }

    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard context == &playerItemContext else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItem.Status
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItem.Status(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }
            switch status {
            case .readyToPlay:
                print(".readyToPlay")
                if !isCancelled {
                    if let currentItem = player?.currentItem,
                       let urlAsset = currentItem.asset as? AVURLAsset {
                        let key = urlAsset.url.absoluteString
                        if let time = PlayerView.playerTimeCache[key] {
                            player?.seek(to: time) { [weak self] _ in
                                self?.player?.play()
                            }
                        } else {
                            player?.play()
                        }
                    } else {
                        player?.play()
                    }
                    alreadyPlayed = true
                }
            case .failed:
                print(".failed")
            case .unknown:
                print(".unknown")
            @unknown default:
                print("@unknown default")
            }
        }
    }
    
    func prepareToPlay(with url: URL) {
        guard !isPreparing else {
            print("Already preparing... ")
            return
        }
        
        print("prepare video start ")
        isCancelled = false
        isPreparing = true
        setUpAsset(with: url) {[weak self] result in
            switch result {
            case .success(let asset):
                self?.setUpPlayerItem(with: asset)
                print("prepared successfully")
                
            case .failure(let error):
                print("Failed to load asset: \(error)")
                
            }
        }
        
    }
    func cancelPreparation(with url:URL?) {
        isCancelled = true
        isPreparing = false
        if let url = url, let currentTime = player?.currentTime() {
            PlayerView.playerTimeCache[url.absoluteString] = currentTime
           }
        player?.pause()
        //player = nil
        print("Cancelled preparation ")
    }
    
    func resetPlayerView() {
//        player?.pause()
//        
//        player?.replaceCurrentItem(with: nil)
//        alreadyPlayed = false
    }
    
    @objc private func playerDidFinishPlaying(notification: Notification) {
        guard let currentItem = player?.currentItem, currentItem == notification.object as? AVPlayerItem else {
            return
        }

        print("Video finished, replaying...")
        player?.seek(to: .zero) { [weak self] _ in
            self?.player?.play()
        }
    }
    
    deinit {
        playerItem?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
        print("deinit of PlayerView")
    }
    
    
    
    
}
