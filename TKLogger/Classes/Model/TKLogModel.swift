//
//  TKLogModel.swift
//  FBSnapshotTestCase
//
//  Created by Shper on 2020/7/23.
//

import Foundation

public class TKLogModel {
    
    public var isIgnore: Bool = false

    public var level: TKLogLevel = TKLogLevel.verbose
    public var message: String? = nil
    public var internalMessage: String? = nil
    public var clazzName: String? = nil
    public var fileName: String? = nil
    public var functionName: String? = nil
    public var threadName: String? = nil
    public var lineNum: Int? = nil
    
    public init() {
    }
    
}
