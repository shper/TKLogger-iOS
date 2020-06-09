//
//  ExampleLogFilter.swift
//  TKLogger-iOS_Example
//
//  Created by Shper on 2020/6/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import TKLogger

class ExampleLogFilter: TKLogBaseFilter {
    
    override func handleFilter(_ level: TKLogLevel,
                               _ message: String?,
                               _ internalMessage: String?,
                               _ file: String,
                               _ function: String)
        -> (isIgnore: Bool, message: String?, innerMessage: String?, file: String, function: String)
    {
//        let isIgnore = level == TKLogLevel.error
        
//        print(file)
//        print(function)
        
        return (false, message, internalMessage, file, function)
    }
    
}
