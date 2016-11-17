//
//  DetailCarouselItem.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

struct DetailCarouselItem {
    let images: [DetailCarouselImageItem]?
}

extension DetailCarouselItem: ViewControllable {
    var viewController: UIViewController {
        let detailCarouselViewController = CustomPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        detailCarouselViewController.pages = images?.map { $0.viewController }
        
        return detailCarouselViewController
    }
}

extension DetailCarouselItem: PageControllable {
    var selectedImage: UIImage? {
        return UIImage(named: "icon_pictures_active")
    }
    
    var nonSelectedImage: UIImage? {
        return UIImage(named: "icon_pictures_inactive")
    }
}
