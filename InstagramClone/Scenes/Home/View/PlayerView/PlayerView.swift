//
//  PlayerView.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 24/04/2025.
//

import UIKit
import AVFoundation

class PlayerView: UIView {
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
        playerItem = AVPlayerItem(asset: asset)
        playerItem?.addObserver(self, forKeyPath: #keyPath(AVPlayerItem.status), options: [.old, .new], context: &playerItemContext)
            
        DispatchQueue.main.async { [weak self] in
            self?.player = AVPlayer(playerItem: self?.playerItem!)
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
        setUpAsset(with: url) {[weak self] result in
            switch result {
            case .success(let asset):
                self?.setUpPlayerItem(with: asset)
 
            case .failure(let error):
                print("Failed to load asset: \(error)")

            }
        }

    }
    
    deinit {
         playerItem?.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
         print("deinit of PlayerView")
     }

    
}
