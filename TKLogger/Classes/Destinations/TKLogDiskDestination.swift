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
        
        createLogDirectory()
    }
    
    deinit {
        if let fileHandle = fileHandle {
            fileHandle.closeFile()
        }
    }
    
    // MARK: Handle to logs
    
    override public func handlerLog(_ tkLog: TKLogModel) {
        let logStr = formatLog(tkLog)
        
        if !logStr.isEmpty {
            saveToFile(logStr)
        }
    }
    
    func createLogDirectory() {
        guard let baseURL = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return
        }
        
        do {
             let logDir = baseURL.appendingPathComponent("TKLogger", isDirectory: true)
            try fileManager.createDirectory(atPath: logDir.path, withIntermediateDirectories: true, attributes: nil)
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
