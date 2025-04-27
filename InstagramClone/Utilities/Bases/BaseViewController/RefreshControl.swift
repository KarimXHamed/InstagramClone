//
//  RefreshControl.swift
//  InstagramClone
//
//  Created by Karim Hamed on 24/06/2025.
//

import UIKit

final class RefreshControl {

    private let refreshControl = UIRefreshControl()

    func setup(in scrollView: UIScrollView, target: Any?, action: Selector) {
        scrollView.refreshControl = refreshControl
        refreshControl.addTarget(target, action: action, for: .valueChanged)
    }

    func stop() {
        refreshControl.endRefreshing()
    }
}
