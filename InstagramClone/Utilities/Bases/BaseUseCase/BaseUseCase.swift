//
//  BaseUseCase.swift
//  AlTasherat-IOS-G2-T1
//
//  Created by mayar on 24/03/2025.
//

import Foundation

class BaseUseCase: BaseUseCaseProtocol {

    func mapErrors(errors: [FieldKey: [AltasheratExceptions]]) -> [AltasheratExceptions] {
        var mappedErrors: [AltasheratExceptions] = []
        for error in errors {
            if !error.value.isEmpty {
                mappedErrors.append(contentsOf: error.value)
            }
        }
        return mappedErrors
    }
    func filterErrors(errors:[FieldKey:[AltasheratExceptions]])->[FieldKey:[AltasheratExceptions]]{
        return errors.filter { !$0.value.isEmpty }
    }
}
