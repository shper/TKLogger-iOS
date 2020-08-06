//
//  TKLoggerBaseHandler.swift
//  FBSnapshotTestCase
//
//  Created by Shper on 2020/5/31.
//
import Foundation

open class TKLogBaseDestination: Hashable, Equatable {
    
    open var format = "$Dyyyy-MM-dd HH:mm:ss $C $L/$T $t $F.$f:$l - $M $I"
    
    /// set custom log level words for each level
    open var levelString = LevelString()
    
    /// set custom log level colors for each level
    open var levelColor = LevelColor()
    
    public struct LevelString {
        public var verbose = "V"
        public var debug = "D"
        public var info = "I"
        public var warning = "W"
        public var error = "E"
    }
    
    // For a colored log level word in a logged line
    public struct LevelColor {
        public var verbose = "💜"     // silver
        public var debug = "💚"       // green
        public var info = "💙"        // blue
        public var warning = "💛"     // yellow
        public var error = "💔"       // red
    }
    
    public init() {
    }
    
    open func handlerLog(_ tkLog: TKLogModel) {
    }
    
    // MARK: Format
    
    func formatLog(_ tkLog: TKLogModel) -> String {
        
        var text = ""
        let phrases = ("$i" + format).split(separator: "$")
        
        for phrase in phrases where !phrases.isEmpty {
            
            let phrasePrefix = phrase[phrase.startIndex]
            let remainingPhrase = phrase[phrase.index(phrase.startIndex, offsetBy: 1)..<phrase.endIndex]
            
            switch phrasePrefix {
            case "i": // ignore
                text += remainingPhrase
            case "D": // Date
                text += formatDate(String(remainingPhrase))
            case "C": // LevelColor
                text += paddedString(colorForLevel(tkLog.level) , String(remainingPhrase))
            case "L": // Level
                text += paddedString(levelWord(tkLog.level) , String(remainingPhrase))
            case "T": // Tag
                text += paddedString(loggerTag() , String(remainingPhrase))
            case "t": // threadName
                text += paddedString(tkLog.threadName , String(remainingPhrase))
            case "c": // clazzName
                text += paddedString(tkLog.clazzName, String(remainingPhrase))
            case "F": // fileName
                text += paddedString(tkLog.fileName , String(remainingPhrase))
            case "f": // functionName
                text += paddedString(tkLog.functionName , String(remainingPhrase))
            case "l": // line
                text += paddedString(String(tkLog.lineNum ?? -1) , String(remainingPhrase))
            case "M": // Message
                text += paddedString(tkLog.message, String(remainingPhrase))
            case "I": // internal
                text += paddedString(tkLog.internalMessage, String(remainingPhrase))
            default:
                text += phrase
            }
        }
        
        return text
    }
    
    func paddedString(_ str1: String?, _ str2: String) -> String {
        var str = (str1 ?? "") + str2
        if str == " " {
            str = ""
        }
        
        return str
    }
    
    func formatDate(_ dateFormat: String, timeZone: String = "") -> String {
        let formatter = DateFormatter()
        
        if !timeZone.isEmpty {
            formatter.timeZone = TimeZone(abbreviation: timeZone)
        }
        
        formatter.dateFormat = dateFormat
        let dateStr = formatter.string(from: Date())
        
        return dateStr
    }
    
    /// returns color string for level
    func colorForLevel(_ level: TKLogLevel) -> String {
        var color = ""
        
        switch level {
        case .debug:
            color = levelColor.debug
            
        case .info:
            color = levelColor.info
            
        case .warning:
            color = levelColor.warning
            
        case .error:
            color = levelColor.error
            
        default:
            color = levelColor.verbose
        }
        return color
    }
    
    /// returns the string of a level
    func levelWord(_ level: TKLogLevel) -> String {
        var str = ""
        
        switch level {
        case .debug:
            str = levelString.debug
        case .info:
            str = levelString.info
        case .warning:
            str = levelString.warning
        case .error:
            str = levelString.error
        default:
            // Verbose is default
            str = levelString.verbose
        }
        
        return str
    }
    
    func loggerTag() -> String {
        return TKLogger.loggerTag
    }
    
    // MARK: Hashable 、Equatable
    public func hash(into hasher: inout Hasher) {
        // do noting.
    }
    
    public static func == (lhs: TKLogBaseDestination, rhs: TKLogBaseDestination) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
}
