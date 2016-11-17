//
//  ViewControllable.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

protocol ViewControllable {
    var viewController: UIViewController { get }
}

protocol PageControllable {
    var selectedImage: UIImage? { get }
    var nonSelectedImage: UIImage? { get }
}

extension PageControllable {
    func image(for selected: Bool) -> UIImage? {
        return selected ? selectedImage : nonSelectedImage
    }
}
