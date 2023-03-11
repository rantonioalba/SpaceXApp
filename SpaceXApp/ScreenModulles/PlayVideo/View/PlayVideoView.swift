//
//  PlayVideoView.swift
//  SpaceXApp
//
//  Created by Roberto Antonio Alba Hernandez on 09/03/23.
//

import UIKit
import youtube_ios_player_helper

class PlayVideoView: UIViewController {
    var viewModel: PlayVideoViewModel!
    @IBOutlet weak var playerView: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configPlayerView()
    }
    
    func configPlayerView() {
        let playerVars : [AnyHashable : Any] = ["playsinline":0, "controls":1, "autohide":1, "showinfo":0, "modestbranding":0]
        
        playerView.load(withVideoId: viewModel.getVideoId(), playerVars: playerVars)
        playerView.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerExited), name: UIWindow.didBecomeHiddenNotification, object: nil)
    }
    
    @objc func playerExited()  {
        viewModel.exitPlayer()
    }
}

extension PlayVideoView:YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
