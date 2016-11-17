//
//  TravelItem.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import Foundation

struct TravelItem {
    // MARK: Types
    
    enum Group: String {
        case movie
        case hungry
        case once
        
        static let allGroups: [Group] = [.movie, .hungry, .once]
        
        func headerDescription() -> String {
            switch self {
            case .movie:
                return "Movie destinations"
            case .hungry:
                return "Hungry for travel"
            case .once:
                return "Once upon a time"
            }
        }
    }
    
    // MARK: Properties
    
    let group: Group
    
    let number: Int
    
    let slides: Int
    
    let title: String
    
    let subTitle: String
    
    var identifier: String {
        return "\(group.rawValue).\(number)"
    }
}
