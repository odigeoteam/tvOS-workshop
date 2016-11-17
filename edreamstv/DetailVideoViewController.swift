//
//  DetailVideoViewController.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit
import AVKit

class DetailVideoViewController: AVPlayerViewController {
    
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = url else { return }

        player = AVPlayer(url: url)
        requiresLinearPlayback = true
        videoGravity = AVLayerVideoGravityResizeAspectFill
        player?.play()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
