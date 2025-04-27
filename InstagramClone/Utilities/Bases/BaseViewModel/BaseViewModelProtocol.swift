//
//  BaseViewModelProtocol.swift
//  AlTasherat-IOS-G2-T1
//
//  Created by mayar on 24/03/2025.
//

import Foundation
import Combine

protocol BaseViewModelProtocol {

    var shouldReloadPublisher: Published<Bool>.Publisher { get }
    var loadingPublisher: Published<Bool>.Publisher { get }
    var errorPublisher: Published<String?>.Publisher { get }
}
