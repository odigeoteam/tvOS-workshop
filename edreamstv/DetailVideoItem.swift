//
//  DetailVideoItem.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

struct DetailVideoItem {
    let url: URL
}

extension DetailVideoItem: ViewControllable {
    var viewController: UIViewController {
        let detailVideoViewController = DetailVideoViewController()
        detailVideoViewController.url = url
        
        return detailVideoViewController
    }
}

extension DetailVideoItem: PageControllable {
    var selectedImage: UIImage? {
        return UIImage(named: "icon_video_active")
    }
    
    var nonSelectedImage: UIImage? {
        return UIImage(named: "icon_video_inactive")
    }
}
