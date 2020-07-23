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

    open func handleFilter(_ tkLog: TKLogModel) -> TKLogModel {
        return tkLog
    }

    // MARK: Hashable 、Equatable
    
    public func hash(into hasher: inout Hasher) {
        // do noting.
    }

    public static func == (lhs: TKLogBaseFilter, rhs: TKLogBaseFilter) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }

}
