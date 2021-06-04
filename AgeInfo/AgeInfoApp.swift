//
//  AgeInfoApp.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/24/21.
//

import SwiftUI
import GoogleMobileAds
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import Keys

@main
struct AgeInfoApp: App {
    init() {
        GADMobileAds.sharedInstance()
        let keys = AgeInfoKeys()
        #if !DEBUG
        AppCenter.start(withAppSecret: keys.appCenterAnalitycs, services: [Analytics.self, Crashes.self])
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
