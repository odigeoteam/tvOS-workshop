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
        //TODO: Step 4
    }
    
    func didUpdateFocusIn(_ travelItem: TravelItem) {
        
        //TODO: Step 2
    }
}
