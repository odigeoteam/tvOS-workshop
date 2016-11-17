//
//  Constants.swift
//  edreamsTVML
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import Foundation

struct Constants {
    
    struct URL {
        static let baseURL = "http://127.0.0.1:9001/"
        static let bootPath = "js/application.js"
        
        static var bootURL: String {
            get {
                return "\(URL.baseURL)\(URL.bootPath)"
            }
        }
    }
}

extension String  {
    func url() -> URL? {
        return URL(string: self)
    }
}
