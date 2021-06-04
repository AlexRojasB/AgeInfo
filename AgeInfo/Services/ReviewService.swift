//
//  ReviewService.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 6/3/21.
//

import Foundation
import StoreKit

class ReviewService {
    private init () {}
    static let shared = ReviewService()
    private let lastRequestString = "ReviewServicce.lastRequest"
    private let defaults = UserDefaults.standard
    
    private var lastRequest: Date? {
        get {
            return defaults.value(forKey: lastRequestString) as? Date
        }
        set {
            defaults.set(newValue, forKey: lastRequestString)
        }
    }
    
    private var oneWeekAgo: Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: Date())!
    }
    
    private var shouldRequestReview: Bool {
        if lastRequest == nil {
            return true
        } else if let lastRequest = self.lastRequest, lastRequest < oneWeekAgo {
            return true
        }
        return false
    }
    
    
    func requestReview(isWrittenReview: Bool = false) {
        guard shouldRequestReview else {
            return
        }
        if isWrittenReview {
           // let appStoreUrl = URL(string: "https://itunes.apple.com/app/idxxxx?action=write-review")!
            // open browser
        }
        if let scene = UIApplication.shared.currentScene {
            SKStoreReviewController.requestReview(in: scene)
            lastRequest = Date()
        }
    }
}
