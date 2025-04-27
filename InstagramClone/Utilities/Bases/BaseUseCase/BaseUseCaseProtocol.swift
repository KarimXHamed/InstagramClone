//
//  BaseUseCaseProtocol.swift
//  AlTasherat-IOS-G2-T1
//
//  Created by mayar on 24/03/2025.
//

import Foundation

protocol BaseUseCaseProtocol {
    
     func mapErrors(errors: [FieldKey: [AltasheratExceptions]]) -> [AltasheratExceptions]
    
}
