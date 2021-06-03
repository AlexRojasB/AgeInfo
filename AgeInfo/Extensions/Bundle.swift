//
//  Bundle.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/26/21.
//

import Foundation
extension Bundle {
    public var release: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String? ?? "x.x"
    }
    public var build: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String? ?? "x"
    }
    public var version: String {
        return "\(release).\(build)"
    }
}
