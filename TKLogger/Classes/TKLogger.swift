//
//  TKLogger.swift
//  FBSnapshotTestCase
//
//  Created by Shper on 2020/5/31.
//

import Foundation

public final class TKLogger {
    
    public enum Level: Int {
        case verbose = 0
        case debug = 1
        case info = 2
        case warning = 3
        case error = 4
    }
    
    public private(set) static var destinations = Set<TKLoggerBaseDestination>()
    
    private(set) static var loggerTag = "TKLogger"
    
    public static func setup(tag: String = "TKLogger") {
        loggerTag = tag
        
        addDestination(TKLoggerConsoleDestination())
        addDestination(TKLoggerFileDestination())
    }
    
    // MARK: Handler
    @discardableResult
    public class func addDestination(_ handler: TKLoggerBaseDestination) -> Bool {
        if destinations.contains(handler) {
            return false
        }
        
        destinations.insert(handler)
        return true
    }
    
    // MARK: Levels
    public static func verbose(_ message: String,
                               _ file: String = #file,
                               _ function: String = #function,
                               _ line: Int = #line) {
        dispatchLog(TKLogger.Level.verbose, message, file, function, line)
    }
    
    public static func debug(_ message: String,
                             _ file: String = #file,
                             _ function: String = #function,
                             _ line: Int = #line) {
        dispatchLog(TKLogger.Level.debug, message, file, function, line)
    }
    
    public static func info(_ message: String,
                            _ file: String = #file,
                            _ function: String = #function,
                            _ line: Int = #line) {
        dispatchLog(TKLogger.Level.info, message, file, function, line)
    }
    
    public static func warning(_ message: String,
                               _ file: String = #file,
                               _ function: String = #function,
                               _ line: Int = #line) {
        dispatchLog(TKLogger.Level.warning, message, file, function, line)
    }
    
    public static func error(_ message: String,
                             _ file: String = #file,
                             _ function: String = #function,
                             _ line: Int = #line) {
        dispatchLog(TKLogger.Level.error, message, file, function, line)
    }
    
    // MARK: Inner function
    
    private static func dispatchLog (_ level: TKLogger.Level,
                                     _ message: String,
                                     _ file: String,
                                     _ function: String,
                                     _ line: Int) {
        
        let thread = threadName()
        
        for handler in destinations {
            guard let queue = handler.queue else { continue }
            
            if handler.asynchronously {
                queue.async {
                    _ = handler.handlerLog(level, message, "", thread, file, function, line)
                }
            } else {
                queue.sync {
                    _ = handler.handlerLog(level, message, "", thread, file, function, line)
                }
            }
        }
    }
    
    private static func threadName() -> String {
        if Thread.isMainThread {
            return ""
        }
        
        let threadName = Thread.current.name
        if let threadName = threadName, !threadName.isEmpty {
            return threadName
        } else {
            return String(format: "%p", Thread.current)
        }
    }
    
}
