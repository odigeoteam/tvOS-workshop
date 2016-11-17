//
//  UIViewController+StoryboardLoadable.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

protocol StoryboardLoadable: class {
    static func viewController(_ storyboardName: String) -> UIViewController
}

extension StoryboardLoadable where Self: UIViewController {
    static final func viewController(_ storyboardName: String = "Main") -> UIViewController {
        let bundle = Bundle(for: Self.self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: Self.storyboardIdentifier) as? Self else {
            fatalError("Unable to instaciate viewcontroller.")
        }
        
        return viewController
    }
}
