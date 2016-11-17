//
//  ExtendedInterfaceCreator.swift
//  edreamsTVML
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import UIKit
import TVMLKit

class ExtendedInterfaceCreator: NSObject {

    override init() {
        super.init()
    }
}

extension ExtendedInterfaceCreator: TVInterfaceCreating {
    func makeViewController(element: TVViewElement, existingViewController: UIViewController?) -> UIViewController? {
        switch element.name {
            case "customDetailTemplate":
                
                var detailViewController: PageWithCustomIndicatorViewController
                if let existingViewController = existingViewController as? PageWithCustomIndicatorViewController {
                    detailViewController = existingViewController
                } else {
                    detailViewController = PageWithCustomIndicatorViewController(transitionStyle: .scroll, navigationOrientation: .vertical, options: nil)
                }
                
                configureCustomDetailViewController(element, detailViewController: detailViewController)
                return detailViewController
        default:
            return nil
        }
    }
        
    fileprivate func configureCustomDetailViewController(_ element: TVViewElement, detailViewController: PageWithCustomIndicatorViewController) {
        
        guard let children = element.children else { return }
        
        var items = [ViewControllable & PageControllable]()
        
        for childElement in children {
            
            switch childElement.name {
            case "video":
                
                guard let videoURL = childElement.attributes?["src"]?.url() else { break }
                items.append(DetailVideoItem(url: videoURL))
            case "carousel":
                
                guard let carouselChildren = childElement.children else { break }
                
                var carouselItems = [DetailCarouselImageItem]()
                for carouselChildElement in carouselChildren {
                    guard carouselChildElement.name == "img", let imgURL = carouselChildElement.attributes?["src"]?.url() else { break }
                    
                    carouselItems.append(DetailCarouselImageItem(imageURL: imgURL))
                }
                
                if carouselItems.count > 0 {
                    items.append(DetailCarouselItem(images: carouselItems))
                }
            default:
                break
            }
        }
        
        detailViewController.items = items
    }
}
