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

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.window = UIWindow(frame: UIScreen.main.bounds)
    self.window!.rootViewController = self.makeRootViewController()
    self.window!.makeKeyAndVisible()
    return true
  }
}

extension AppDelegate {
  private func makeRootViewController() -> UIViewController {
    let networkService = NetworkService<BlinkistEndPoint>()
    let navigationService = NavigationService()
    let startViewModel = StartViewModel(networkService, navigationService)
    return StartViewController(viewModel: startViewModel)
  }
}

