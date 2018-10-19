//
//  AppDelegate.swift
//  WhatsNow
//
//  Created by David Buhauer on 16/09/2018.
//  Copyright © 2018 Dabdeveloper. All rights reserved.
//

import UIKit

@UIApplicationMain
class WNAppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let tabBarCon: WNTabBarController = WNTabBarController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.setupTracking()
        self.setupAppearance()
        self.setupTabBar()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.tabBarCon
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func setupAppearance() {
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        // Sets the translucent background color
        UINavigationBar.appearance().backgroundColor = .white
        // Set translucent. (Default value is already true, so this can be removed if desired.)
        UINavigationBar.appearance().isTranslucent = true
        
        // Tabbar selected item color
        UITabBar.appearance().tintColor = WNFormatUtil.themeColorBlue()
        
        // Tabbar unselected item color
        UITabBar.appearance().unselectedItemTintColor = UIColor.darkGray
        
        // Navigation item color
        UIBarButtonItem.appearance().tintColor = WNFormatUtil.themeColorBlue()
    }
    
    func setupTabBar() {
        let eventsVc = WNEventsVC()
        let eventsNavCon = UINavigationController(rootViewController: eventsVc)
        eventsVc.tabBarItem = UITabBarItem(title: "home".localized, image: UIImage(named: "icon_home_outline_black.png"), selectedImage: UIImage(named: "icon_home_filled_black.png"))
        eventsVc.tabBarItem.tabBarItemShowingOnlyImage()
        eventsNavCon.navigationBar.prefersLargeTitles = true
        
        let searchVc = WNSearchVC()
        let searchNavCon = UINavigationController(rootViewController: searchVc)
        searchNavCon.tabBarItem = UITabBarItem(title: "search".localized, image: UIImage(named: "icon_search_black.png"), selectedImage: UIImage(named: "icon_search_black.png"))
        searchNavCon.tabBarItem.tabBarItemShowingOnlyImage()
        searchNavCon.navigationBar.prefersLargeTitles = true
        
        let nearMeVc = WNNearMeVC()
        let nearMeNavCon = UINavigationController(rootViewController: nearMeVc)
        nearMeNavCon.tabBarItem = UITabBarItem(title: "near_me".localized, image: UIImage(named: "icon_marker_outline_black.png"), selectedImage: UIImage(named: "icon_marker_filled_black.png"))
        nearMeNavCon.tabBarItem.tabBarItemShowingOnlyImage()
        nearMeNavCon.navigationBar.prefersLargeTitles = true
        
        let favoritesVc = WNFavoritesVC()
        let favoritesNavCon = UINavigationController(rootViewController: favoritesVc)
        favoritesNavCon.tabBarItem = UITabBarItem(title: "favorites".localized, image: UIImage(named: "icon_heart_outline_black.png"), selectedImage: UIImage(named: "icon_heart_filled_black.png"))
        favoritesNavCon.tabBarItem.tabBarItemShowingOnlyImage()
        favoritesNavCon.navigationBar.prefersLargeTitles = true
        
        let profileVc = WNProfileVC()
        let profileNavCon = UINavigationController(rootViewController: profileVc)
        profileNavCon.tabBarItem = UITabBarItem(title: "profile".localized, image: UIImage(named: "icon_profile_outline_black.png"), selectedImage: UIImage(named: "icon_profile_filled_black.png"))
        profileNavCon.tabBarItem.tabBarItemShowingOnlyImage()
        profileNavCon.navigationBar.prefersLargeTitles = true
        
        self.tabBarCon.setViewControllers([eventsNavCon, searchNavCon, nearMeNavCon, favoritesNavCon, profileNavCon], animated: true)
    }
    
    func setupTracking() {
        
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

