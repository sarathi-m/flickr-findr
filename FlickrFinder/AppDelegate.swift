//
//  AppDelegate.swift
//  FlickrFinder
//
//  Created by Sarathi Murugesan on 11/4/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let searchView = SearchViewRouter.createModule()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: searchView)
        window?.makeKeyAndVisible()
        
        return true
    }
}

