//
//  TravelItem+DetailItems.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import Foundation

extension TravelItem {
    
    func detailItems() -> [ViewControllable & PageControllable] {
        
        var items = [ViewControllable & PageControllable]()
        
        if let url = videoURL {
            items.append(DetailVideoItem(url: url))
        }
        
        if slides > 0 {
            let itemImages = (1...slides).map { DetailCarouselImageItem(imageURL: slide(for: $0)!) }
            items.append(DetailCarouselItem(images: itemImages))
        }
        
        return items
    }
}
