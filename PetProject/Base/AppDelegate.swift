//
//  AppDelegate.swift
//  PetProject
//
//  Created by Lobanov Vladimir on 3/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    if let window = window {
      let navigationController = UINavigationController()
      let usersVC = UsersContainer.assemble().viewController
      navigationController.viewControllers = [usersVC]
      window.rootViewController = navigationController
      window.makeKeyAndVisible()
      window.backgroundColor = .white
    }
    return true
  }
}
