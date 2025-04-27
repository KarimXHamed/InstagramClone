//
//  RefreshControl.swift
//  AlTasherat-IOS-G2-T1
//
//  Created by mayar on 13/03/2025.
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
