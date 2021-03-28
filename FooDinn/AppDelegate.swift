//
//  AppDelegate.swift
//  FooDinn
//
//  Created by Prabhakaran on 22/03/21.
//

import UIKit

@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

     var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
            
            if #available(iOS 13, *) {
                // do only pure app launch stuff, not interface stuff
            } else {
                 let bounds = UIScreen.main.bounds
                 self.window = UIWindow(frame: bounds)
                 let navController = UINavigationController()
                 let home = HomeRouterInput().view(entryEntity: HomeEntity())
                 navController.setViewControllers([home], animated: false)
                 self.window!.rootViewController = navController
                 self.window!.makeKeyAndVisible()
            }
            
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

