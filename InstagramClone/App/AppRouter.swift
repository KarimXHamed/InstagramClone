//
//  AppRouter.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 23/04/2025.
//
import UIKit
import Factory
class AppRouter {
    private var window: UIWindow
    let rootNavigationController = UINavigationController()

      init(window: UIWindow) {
          self.window = window
          self.window.rootViewController = rootNavigationController
      }
    func start() {
        navToHome()
    }
    
    func navToHome() {
        let homeViewController = Container.homeServiceDI(navigationController: rootNavigationController)
        rootNavigationController.setViewControllers([homeViewController], animated: true)
        window.makeKeyAndVisible()
    }
}
