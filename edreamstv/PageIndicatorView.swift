//
//  PageIndicatorView.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit

class PageIndicatorView: UIView {
    
    private var stackView: UIStackView?
    private var items: [PageControllable]?
    var selectedIndex = 0 {
        willSet {
            guard let items = items, selectedIndex < items.count else { fatalError("Unable to change index") }
        }
        didSet {
            if oldValue != selectedIndex {
                guard let items = items, let stackView = stackView, selectedIndex < items.count, oldValue < items.count, let oldImageView = stackView.arrangedSubviews[oldValue] as? UIImageView, let newImageView = stackView.arrangedSubviews[selectedIndex] as? UIImageView else { fatalError("Unable to change index") }
                
                let oldItem = items[oldValue]
                let newItem = items[selectedIndex]
                
                oldImageView.image = oldItem.image(for: false)
                newImageView.image = newItem.image(for: true)
            }
        }
    }
    
    convenience init(items: [PageControllable]) {
        self.init()
        
        self.items = items
        let images = items.enumerated().map { UIImageView(image: $1.image(for: $0 == selectedIndex)) }
        
        let newStackView = UIStackView(arrangedSubviews: images)
        newStackView.alignment = .center
        newStackView.distribution = .fillProportionally
        newStackView.axis = .vertical
        newStackView.spacing = 20
        newStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.stackView = newStackView
        addSubview(newStackView)
        
        let views = ["stackView" : newStackView]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[stackView]-0-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[stackView]-0-|", options: [], metrics: nil, views: views))
    }
}
