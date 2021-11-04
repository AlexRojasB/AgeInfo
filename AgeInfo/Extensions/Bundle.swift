//
//  Bundle.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/26/21.
//

import Foundation
import UIKit

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
    
    func decode<T: Codable>(_ file: String) -> T {
           guard let url = self.url(forResource: file, withExtension: nil) else {
               fatalError("Failed to locate \(file) in bundle")
           }
           
           guard let data = try? Data(contentsOf: url) else {
               fatalError("Failed to locate \(file) in bundle")
           }
           
           let decoder = JSONDecoder()
           
           guard let loaded = try? decoder.decode(T.self, from: data) else {
               fatalError("Failed to locate \(file) in bundle")
           }
           
           return loaded
       }
}

extension UIApplication {
    var currentScene: UIWindowScene? {
        connectedScenes
            .first { $0.activationState == .foregroundActive } as? UIWindowScene
    }
}
