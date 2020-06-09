//
//  TKLoggerFileDestion.swift
//  FBSnapshotTestCase
//
//  Created by Shper on 2020/6/3.
//
import Foundation

public class TKLogDiskDestination: TKLogBaseDestination {
    
    private static let DATE_FORMAT = "yyyy-MM-dd_HH-mm-ss"
    
    private let fileManager = FileManager.default
    private var fileHandle: FileHandle?
    
    private var logFileURL: URL?
    
    
    // MARK: Lifecycle
    
    override public init() {
        super.init()
        levelColor.verbose = "💜"     // silver
        levelColor.info = "💙"         // blue
        levelColor.debug = "💚"        // green
        levelColor.warning = "💛"     // yellow
        levelColor.error = "💔"       // red
        
        cerateLogDirectory()
    }
    
    deinit {
        if let fileHandle = fileHandle {
            fileHandle.closeFile()
        }
    }
    
    // MARK: XXX
    
    override public func handlerLog(_ level: TKLogLevel,
                                    _ message: String,
                                    _ innerMessage: String,
                                    _ thread: String,
                                    _ file: String,
                                    _ function: String,
                                    _ line: Int) -> String? {
        
        guard let logStr = super.handlerLog(level,
                                            message,
                                            innerMessage,
                                            thread,
                                            file,
                                            function,
                                            line) else { return nil }
        
        saveToFile(logStr)
        return nil
    }
    
    override public var defaultHashValue: Int {
        return 2
    }
    
    func cerateLogDirectory() {
        guard let baseURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return
        }
        
        do {
             let sss = baseURL.appendingPathComponent("TKLogger", isDirectory: true)
            try fileManager.createDirectory(atPath: sss.path, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print(error)
        }
        
        let faileName = "TKLogger/TKLogger_\(formatDate(TKLogDiskDestination.DATE_FORMAT)).log"
        logFileURL = baseURL.appendingPathComponent(faileName, isDirectory: false)
    }
    
    func saveToFile(_ str: String) {
        guard let fileUrl = logFileURL else { return }
        
        do {
            
            if !fileManager.fileExists(atPath: fileUrl.path) {
                
                let line = str + "\n"
                try line.write(to: fileUrl, atomically: true, encoding: .utf8)
                
                if #available(iOS 10.0, watchOS 3.0, *) {
                    var attributes = try fileManager.attributesOfItem(atPath: fileUrl.path)
                    attributes[FileAttributeKey.protectionKey] = FileProtectionType.none
                    try fileManager.setAttributes(attributes, ofItemAtPath: fileUrl.path)
                }
            } else {
                if fileHandle == nil {
                    fileHandle = try FileHandle(forWritingTo: fileUrl as URL)
                }

                if let fileHandle = fileHandle {
                    _ = fileHandle.seekToEndOfFile()
                    let line = str + "\n"
                    if let data = line.data(using: String.Encoding.utf8) {
                        fileHandle.write(data)
                    }
                }
            }
            
        } catch {
            print(error)
        }
    }
    
}
