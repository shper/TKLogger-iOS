//
//  Custom1Destination.swift
//  TKLogger-iOS_Example
//
//  Created by Shper on 2020/10/13.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import TKLogger

public class Custom1Destination: TKLogBaseDestination {
    
    override public func handlerLog(_ tkLog: TKLogModel) {
        print("Custom1Destination")
        
        sleep(2)
        
        print("Custom1Destination")
    }
    
}
