//
//  HomeDI.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 23/04/2025.
//
import Factory
import UIKit
extension Container {
    static func homeServiceDI(navigationController:UINavigationController)->HomeViewController{
        let viewController = HomeViewController()
        return viewController
    }
}
