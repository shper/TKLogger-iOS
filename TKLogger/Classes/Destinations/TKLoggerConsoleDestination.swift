//
//  TKLoggerConsoleHandler.swift
//  FBSnapshotTestCase
//
//  Created by Shper on 2020/6/3.
//
import Foundation

public class TKLoggerConsoleDestination: TKLoggerBaseDestination {
    
    public var useNSLog = false
    
    override public init() {
        super.init()
        levelColor.verbose = "💜"     // silver
        levelColor.info = "💙"         // blue
        levelColor.debug = "💚"        // green
        levelColor.warning = "💛"     // yellow
        levelColor.error = "💔"       // red
    }
    
    override public func handlerLog(_ level: TKLogger.Level,
                                    _ message: String,
                                    _ innerMessage: String,
                                    _ thread: String,
                                    _ file: String,
                                    _ function: String,
                                    _ line: Int) -> String? {
        
        let logString = super.handlerLog(level,
                                         message,
                                         innerMessage,
                                         thread,
                                         file,
                                         function,
                                         line)
        
        if let str = logString {
            if useNSLog {
                NSLog("%@", str)
            } else {
                print(str)
            }
        }
        
        return nil
    }
    
    override public var defaultHashValue: Int {
        return 1
    }
    
}
