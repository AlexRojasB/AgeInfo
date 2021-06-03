//
//  BannerView.swift
//  AgeInfo
//
//  Created by Alexander Rojas Benavides on 5/24/21.
//

import SwiftUI
import GoogleMobileAds
import UIKit
import Keys

struct GADBannerViewController : UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: kGADAdSizeBanner)
        let viewController = UIViewController()
        let keys = AgeInfoKeys()
        view.adUnitID = keys.googleAdMobKey
        view.rootViewController = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: kGADAdSizeBanner.size)
        view.load(GADRequest())
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context)  {
    }
}
