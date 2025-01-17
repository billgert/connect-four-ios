//
//  AppDelegate.swift
//  ConnectFour
//
//  Created by Patrik Billgert on 2018-11-23.
//  Copyright © 2018 Patrik Billgert. All rights reserved.
//

import UIKit

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  private var rootNavigator: GameNavigator!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.rootNavigator = GameNavigator(navigationController: UINavigationController(),
                                       window: UIWindow(frame: UIScreen.main.bounds))
    self.rootNavigator.navigate(to: .start)
    
    return true
  }
}

