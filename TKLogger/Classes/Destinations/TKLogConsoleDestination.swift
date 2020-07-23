//
//  TKLoggerConsoleHandler.swift
//  FBSnapshotTestCase
//
//  Created by Shper on 2020/6/3.
//
import Foundation

public class TKLogConsoleDestination: TKLogBaseDestination {
    
    public var useNSLog = false
    
    override public func handlerLog(_ tkLog: TKLogModel) {
        let logString = formatLog(tkLog)
        if useNSLog {
            NSLog("%@", logString)
        } else {
            print(logString)
        }
    }
    
}
