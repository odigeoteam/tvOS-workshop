//
//  UIViewController+TableViewManagerDelegate.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

protocol ImageBackgroundView: class {
    var imageBackgroundView: UIImageView! { get set }
}

extension TableViewManagerDelegate where Self: UIViewController {
    func didSelect(_ travelItem: TravelItem) {
        let detailViewController = PageWithCustomIndicatorViewController(transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
        detailViewController.item = travelItem
        detailViewController.items = travelItem.detailItems()
        
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func didUpdateFocusIn(_ travelItem: TravelItem) {
        guard let controller = self as? ImageBackgroundView else { return }
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.duration = 0.4
        transition.type = kCATransitionFade
        controller.imageBackgroundView.layer.add(transition, forKey: "Transition")
        controller.imageBackgroundView.image = UIImage(named: travelItem.backgroundImageName)
    }
}
