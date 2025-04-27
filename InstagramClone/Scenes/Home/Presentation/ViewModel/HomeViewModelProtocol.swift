//
//  HomeViewModelProtocol.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Combine
protocol HomeViewModelProtocol:BaseViewModelProtocol,ReelsCollectionViewDelegate {
    func viewWillAppear()
}
