//
//  TravelItem+SampleData.swift
//  edreamstv
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import Foundation

extension TravelItem {

    static var sampleItems: [TravelItem] = {
        return [
            TravelItem(group: .movie, number: 1, slides: 0, title:"San Francisco", subTitle:"LA ROCA"),
            TravelItem(group: .movie, number: 2, slides: 6, title:"New Zealand", subTitle:"The Lord of the Rings"),
            TravelItem(group: .movie, number: 3, slides: 0, title:"Paris", subTitle:"Midnight in Paris"),
            TravelItem(group: .movie, number: 4, slides: 0, title:"New York City", subTitle:"The dark knight rises"),
            TravelItem(group: .movie, number: 5, slides: 0, title:"Chicago", subTitle:"Watchmen"),
            
            TravelItem(group: .hungry, number: 1, slides: 0, title:"Naples", subTitle:"Discover the pizza"),
            TravelItem(group: .hungry, number: 2, slides: 0, title:"Tokyo", subTitle:"The mistery of sushi"),
            TravelItem(group: .hungry, number: 3, slides: 0, title:"New York City", subTitle:"The burger temple"),
            TravelItem(group: .hungry, number: 4, slides: 0, title:"Malaga", subTitle:"Tasty grilled fish"),
            TravelItem(group: .hungry, number: 5, slides: 0, title:"Mexico", subTitle:"The authentic burritos"),
            
            TravelItem(group: .once, number: 1, slides: 0, title:"Rome", subTitle:"All roads lead to Rome"),
            TravelItem(group: .once, number: 2, slides: 0, title:"Egyt", subTitle:"The cradle of civilization"),
            TravelItem(group: .once, number: 3, slides: 0, title:"Cambodia", subTitle:"Kingdom of Wonder"),
            TravelItem(group: .once, number: 4, slides: 0, title:"China", subTitle:"The Great Wall"),
            TravelItem(group: .once, number: 5, slides: 0, title:"Mexico", subTitle:"Amazing Temples"),
        ]
    }()
}

extension TravelItem {
    
    var beautifulDescription: String {
        return "Spectacular glaciers, picturesque fiords, rugged mountains, vast plains, rolling hillsides, subtropical forest, volcanic plateau, miles of coastline with gorgeous sandy beaches - it’s all here. No wonder New Zealand is becoming so popular as a location for movies."
    }
}
