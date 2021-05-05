//
//  Custom2Destination.swift
//  TKLogger-iOS_Example
//
//  Created by Shper on 2020/10/13.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import TKLogger

public class Custom2Destination: TKLogBaseDestination {
    
    override public func handlerLog(_ tkLog: TKLogModel) {
        print("Custom2Destination")
    }
    
}
