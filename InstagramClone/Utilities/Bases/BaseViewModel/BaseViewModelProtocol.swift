//
//  BaseViewModelProtocol.swift
//  InstagramClone
//
//  Created by Karim Hamed on 24/06/2025.
//

import Foundation
import Combine

protocol BaseViewModelProtocol {

    var shouldReloadPublisher: Published<Bool>.Publisher { get }
    var loadingPublisher: Published<Bool>.Publisher { get }
    var errorPublisher: Published<String?>.Publisher { get }
}
