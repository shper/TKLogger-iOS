//
//  ExampleLogFilter.swift
//  TKLogger-iOS_Example
//
//  Created by Shper on 2020/6/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import TKLogger

class VerboseLogFilter: TKLogBaseFilter {
    
    override func handleFilter(_ tkLog: TKLogModel) -> TKLogModel {
        if tkLog.level.rawValue <= TKLogLevel.verbose.rawValue {
            tkLog.isIgnore = true
        }
        
        return tkLog
    }
    
}
