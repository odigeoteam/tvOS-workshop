//
//  DetailCarouselImageItem.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

struct DetailCarouselImageItem {
    let imageURL: URL
}

extension DetailCarouselImageItem: ViewControllable {
    var viewController: UIViewController {
        let detailImageViewController = DetailImageViewController.viewController() as! DetailImageViewController
        
        detailImageViewController.item = self
        return detailImageViewController
    }
}

