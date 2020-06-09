//
//  TKLoggerBaseHandler.swift
//  FBSnapshotTestCase
//
//  Created by Shper on 2020/5/31.
//
import Foundation

open class TKLogBaseDestination: Hashable, Equatable {
    
    lazy public var hashValue: Int = self.defaultHashValue
    
    open var defaultHashValue: Int {
        return 0
    }
    
    open var format = "$Dyyyy-MM-dd HH:mm:ss $C $L/$T $t $N.$F:$l - $M $I"
    
    /// runs in own serial background thread for better performance
    open var asynchronously = true
    
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
    // empty on default
    public struct LevelColor {
        public var verbose = ""     // silver
        public var debug = ""       // green
        public var info = ""        // blue
        public var warning = ""     // yellow
        public var error = ""       // red
    }
    
    var queue: DispatchQueue?
    
    public init() {
        let uuid = NSUUID().uuidString
        let queueLabel = "TKLog-queue-" + uuid
        queue = DispatchQueue(label: queueLabel, target: queue)
    }
    
    @discardableResult
    open func handlerLog(_ level: TKLogLevel,
                         _ message: String,
                         _ innerMessage: String?,
                         _ thread: String,
                         _ file: String,
                         _ function: String,
                         _ line: Int) -> String? {
        
        return formatMessage(level, message, innerMessage, thread, file, function, line)
    }
    
    // MARK: Format
    
    func formatMessage(_ level: TKLogLevel,
                       _ message: String,
                       _ innerMessage: String?,
                       _ thread: String,
                       _ file: String,
                       _ function: String,
                       _ line: Int) -> String {
        
        var text = ""
        let phrases = ("$i" + format).split(separator: "$")
        
        for phrase in phrases where !phrases.isEmpty {
            
            let phrasePrefix = phrase[phrase.startIndex]
            let remainingPhrase = phrase[phrase.index(phrase.startIndex, offsetBy: 1)..<phrase.endIndex]
            
            switch phrasePrefix {
            case "i": // ignore
                text += remainingPhrase
            case "D":
                text += formatDate(String(remainingPhrase))
            case "C":
                text += paddedString(colorForLevel(level) , String(remainingPhrase))
            case "L":
                text += paddedString(levelWord(level) , String(remainingPhrase))
            case "T":
                text += paddedString(loggerTag() , String(remainingPhrase))
            case "t":
                text += paddedString(thread , String(remainingPhrase))
            case "N":
                text += paddedString(file , String(remainingPhrase))
            case "F":
                text += paddedString(function , String(remainingPhrase))
            case "l":
                text += paddedString(String(line) , String(remainingPhrase))
            case "M":
                text += paddedString(message , String(remainingPhrase))
            case "I":
                text += paddedString(innerMessage ?? "" , String(remainingPhrase))
            default:
                text += phrase
            }
        }
        
        return text
    }
    
    func paddedString(_ str1: String, _ str2: String) -> String {
        var str = str1 + str2
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
