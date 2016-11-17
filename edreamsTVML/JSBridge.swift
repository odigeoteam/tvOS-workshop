//
//  JSBridge.swift
//  edreamsTVML
//
//  Copyright © 2016 eDreams Odigeo. All rights reserved.
//

import TVMLKit

@objc protocol JSBridgeProtocol : JSExport {
    func wannaTravel(toDestination destination: String)
}

class JSBridge: NSObject, JSBridgeProtocol {
    func wannaTravel(toDestination destination: String) {
        print("Ains... Ojalá estuviese en \(destination)")
    }
}
