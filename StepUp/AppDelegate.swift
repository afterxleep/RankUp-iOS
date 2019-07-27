//
//  AppDelegate.swift
//  StepUp
//
//  Created by Daniel Bernal on 7/13/19.
//  Copyright © 2019 All rights reserved.
//
import UIKit
import MSAL


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        MSALGlobalConfig.loggerConfig.setLogCallback { (logLevel, message, containsPII) in
            if (!containsPII) {
            }
        }
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        guard let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String else {
            return false
        }
        return MSALPublicClientApplication.handleMSALResponse(url, sourceApplication: sourceApplication)
    }
    
}
