//
//  TKLogBaseFilter.swift
//  FBSnapshotTestCase
//
//  Created by Shper on 2020/6/9.
//

import Foundation

open class TKLogBaseFilter: Hashable, Equatable {
    
    public init() {
    }

    open func handleFilter(_ level: TKLogLevel,
                           _ message: String?,
                           _ internalMessage: String?,
                           _ file: String,
                           _ function: String)
        -> (isIgnore: Bool, message: String?, innerMessage: String?, file: String, function: String)
    {
        return (false, message, internalMessage, file, function)
    }

    // MARK: Hashable 、Equatable
    
    public func hash(into hasher: inout Hasher) {
        // do noting.
    }

    public static func == (lhs: TKLogBaseFilter, rhs: TKLogBaseFilter) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }

}
