//
//  Mapper.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Foundation

protocol Mapper {
    associatedtype Dto
    associatedtype Domain
    func dtoToDomain(_ dto: Dto) -> Domain
    func domainToDto(_ domain: Domain) -> Dto
}

