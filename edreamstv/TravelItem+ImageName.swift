//
//  TravelItem+ImageName.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import Foundation

extension TravelItem {
    var imageName: String {
        return "\(group.rawValue) \(number).jpg"
    }
    
    var backgroundImageName: String {
        return "\(group.rawValue) \(number) background.jpg"
    }
    
    var videoURL: URL? {
        guard let path = Bundle.main.path(forResource: "awakening", ofType: "mp4") else { return nil }
        
        return URL(fileURLWithPath: path)
    }
    
    func slide(for index: Int) -> URL? {
        guard index <= slides else { fatalError("Slide out of bounds") }
        
        return Bundle.main.url(forResource: "\(group.rawValue) \(number) \(index)", withExtension: "jpg")
    }
}
