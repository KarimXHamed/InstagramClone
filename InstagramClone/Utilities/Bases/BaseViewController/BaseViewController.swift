//
//  BaseViewController.swift
//  AlTasherat-IOS-G2-T1
//
//  Created by mayar on 13/03/2025.
//

import UIKit
import Combine

class BaseViewController: UIViewController {

    // MARK: - Utilities
    private let loadingIndicator = LoadingIndicator()
    lazy var refreshControlUtility = RefreshControl()
    var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
          super.viewDidLoad()
          navigationItem.hidesBackButton = true
      }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupTapGestureRecognizer()
    }

    private func setupTapGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func handleTap(_ gesture: UITapGestureRecognizer) {}
    
    // MARK: - Loading Indicator
    func setupLoadingIndicator() {
        loadingIndicator.setup(in: view)
    }

    func showLoadingIndicator() {
        loadingIndicator.show()
    }

    func hideLoadingIndicator() {
        loadingIndicator.hide()
    }

    // MARK: - Refresh Control
    func setupRefreshControl() {
        if let scrollView = view as? UIScrollView {
            refreshControlUtility.setup(in: scrollView, target: self, action: #selector(handleRefresh))
        } else {
            for subview in view.subviews {
                if let scrollView = subview as? UIScrollView {
                    refreshControlUtility.setup(in: scrollView, target: self, action: #selector(handleRefresh))
                    break
                }
            }
        }
    }

    func stopRefreshing() {
        refreshControlUtility.stop()
    }

    @objc func handleRefresh() {
        stopRefreshing()
    }

    // MARK: - Error Alerts
    func showErrorAlert(message: String, title: String = "error".localized) {
        AlertPresenter.showErrorAlert(on: self, message: message, title: title)
    }
    func showAlertTwoActions(
                                          message: String,
                                          title: String = "error".localized,
                                          firstButtonTitle: String,
                                          firstAction: (() -> Void)? = nil,
                                          secondButtonTitle: String? = nil,
                                          secondAction: (() -> Void)? = nil
    ){
        AlertPresenter.showAlertTwoActions(on: self, message: message, title: title ,firstButtonTitle: firstButtonTitle, firstAction: firstAction, secondButtonTitle: secondButtonTitle, secondAction: secondAction)
    }
    
    func showSuccessAlert(successMessage: String) {
        let alert = UIAlertController(title: "success".localized, message: successMessage, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK".localized, style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

