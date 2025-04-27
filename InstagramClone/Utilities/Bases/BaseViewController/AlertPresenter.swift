//
//  AlertPresenter.swift
//  AlTasherat-IOS-G2-T1
//
//  Created by mayar on 13/03/2025.
//

import UIKit

final class AlertPresenter {

    static func showErrorAlert(on viewController: UIViewController, message: String, title: String = "error".localized) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK".localized, style: .default))
        viewController.present(alertController, animated: true)
    }
    
    static func showAlertTwoActions (
        on viewController: UIViewController,
        message: String,
        title: String = "error".localized,
        firstButtonTitle: String,
        firstAction: (() -> Void)? = nil,
        secondButtonTitle: String? = nil,
        secondAction: (() -> Void)? = nil
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let firstAction = UIAlertAction(title: firstButtonTitle, style: .default) { _ in
            firstAction?()
        }
        alertController.addAction(firstAction)
        if let secondButtonTitle = secondButtonTitle {
            let secondAlertAction = UIAlertAction(title: secondButtonTitle, style: .cancel) { _ in
                if let secondAction = secondAction {
                    secondAction()
                } else {
                    alertController.dismiss(animated: true)
                }
            }
            alertController.addAction(secondAlertAction)
        }
        viewController.present(alertController, animated: true)
    }

}
