//
//  DetailVideoViewController.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit
import AVKit

//TODO: Step 4
class DetailVideoViewController: UIViewController {
    
    var url: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = url else { return }
        print(url.absoluteString)
        
        //TODO: Step 4
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
