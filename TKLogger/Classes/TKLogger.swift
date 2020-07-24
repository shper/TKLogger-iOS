//
//  TKLogger.swift
//  FBSnapshotTestCase
//
//  Created by Shper on 2020/5/31.8089
//

import Foundation

public final class TKLogger {
    
    public static var loggerTag = "TKLogger"
    
    /// do not log any message which has a lower level than this one
    public static var minLevel = TKLogLevel.verbose
    
    static var queue: DispatchQueue?
    
    private(set) static var destinations = Set<TKLogBaseDestination>()
    private(set) static var filters = Array<TKLogBaseFilter>()
    
    public static func setup(tag: String = "TKLogger", level: TKLogLevel = TKLogLevel.verbose) {
        loggerTag = tag
        minLevel = level

        let queueLabel = "TKLog-queue-" + NSUUID().uuidString
        queue = DispatchQueue(label: queueLabel, target: queue)
    }
    
    // MARK: Destination
    @discardableResult
    public static func addDestination(_ destination: TKLogBaseDestination) -> Bool {
        if destinations.contains(destination) {
            return false
        }
        
        destinations.insert(destination)
        return true
    }
    
    // MARK: Filter
    @discardableResult
    public static func addFilter(_ filter: TKLogBaseFilter) -> Bool {
        if filters.contains(filter) {
            return false
        }
        
        filters.append(filter)
        return true
    }
    
    @discardableResult
    public static func addFilter(_ filter: TKLogBaseFilter, priority: Int) -> Bool {
        if filters.contains(filter) {
            return false
        }
        
        filters.insert(filter, at: priority)
        return true
    }
    
    // MARK: Levels
    
    public static func verbose(_ message: String? = nil,
                               _ internalMessage: String? = nil,
                               _ file: String = #file,
                               _ function: String = #function,
                               _ line: Int = #line) {
        dispatchLog(TKLogLevel.verbose, message, internalMessage, file, function, line)
    }
    
    public static func debug(_ message: String?  = nil,
                             _ internalMessage: String? = nil,
                             _ file: String = #file,
                             _ function: String = #function,
                             _ line: Int = #line) {
        dispatchLog(TKLogLevel.debug, message, internalMessage, file, function, line)
    }
    
    public static func info(_ message: String? = nil,
                            _ internalMessage: String? = nil,
                            _ file: String = #file,
                            _ function: String = #function,
                            _ line: Int = #line) {
        dispatchLog(TKLogLevel.info, message, internalMessage, file, function, line)
    }
    
    public static func warning(_ message: String?  = nil,
                               _ internalMessage: String? = nil,
                               _ file: String = #file,
                               _ function: String = #function,
                               _ line: Int = #line) {
        dispatchLog(TKLogLevel.warning, message, internalMessage, file, function, line)
    }
    
    public static func error(_ message: String? = nil,
                             _ internalMessage: String? = nil,
                             _ file: String = #file,
                             _ function: String = #function,
                             _ line: Int = #line) {
        dispatchLog(TKLogLevel.error, message, internalMessage, file, function, line)
    }
    
    // MARK: Inner function
    
    private static func dispatchLog (_ level: TKLogLevel,
                                     _ message: String? = nil,
                                     _ internalMessage: String? = nil,
                                     _ file: String,
                                     _ function: String,
                                     _ line: Int) {
        
        if (level.rawValue < minLevel.rawValue) {
            return
        }
        
        var tkLog: TKLogModel = TKLogModel()
        tkLog.level = level
        tkLog.message = message
        tkLog.threadName = getThreadName()
        tkLog.internalMessage = internalMessage
        tkLog.fileName = fileNameWithoutSuffix(file)
        tkLog.functionName = function
        tkLog.lineNum = line
        
        queue?.async {
            // Use filters to process logs
            for filter in filters {
                tkLog = filter.handleFilter(tkLog)
            
                if (tkLog.isIgnore) {
                    return
                }
            }
        
            // dispatch the logs to destination
            for destination in destinations {
                destination.handlerLog(tkLog)
            }
        }
    }
    
    private static func getThreadName() -> String {
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
    
    /// returns the filename without suffix (= file ending) of a path
    private static func fileNameWithoutSuffix(_ file: String) -> String {
        let fileName = fileNameOfFile(file)
        
        if !fileName.isEmpty {
            let fileNameParts = fileName.components(separatedBy: ".")
            if let firstPart = fileNameParts.first {
                return firstPart
            }
        }
        return ""
    }
    
    /// returns the filename of a path
    private static func fileNameOfFile(_ file: String) -> String {
        let fileParts = file.components(separatedBy: "/")
        if let lastPart = fileParts.last {
            return lastPart
        }
        return ""
    }
    
}
