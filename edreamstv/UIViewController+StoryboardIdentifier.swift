//
//  ViewController+StoryboardIdentifier.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

protocol StoryboardIdentifier: class {
    static var storyboardIdentifier: String { get }
}

extension UIViewController: StoryboardIdentifier {
    static var storyboardIdentifier: String {
        get {
            return String(describing: self)
        }
    }
}
