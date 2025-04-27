//
//  LoadingIndicator.swift
//  InstagramClone
//
//  Created by Karim Hamed on 24/06/2025.
//
import UIKit

final class LoadingIndicator {

    private let activityIndicator = UIActivityIndicatorView(style: .large)

    func setup(in view: UIView) {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func show() {
        activityIndicator.startAnimating()
    }

    func hide() {
        activityIndicator.stopAnimating()
    }
}
