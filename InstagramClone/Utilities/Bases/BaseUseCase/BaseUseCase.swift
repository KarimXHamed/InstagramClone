//
//  BaseUseCase.swift
//  InstagramClone
//
//  Created by Karim Hamed on 24/06/2025.
//

import Foundation

class BaseUseCase: BaseUseCaseProtocol {

    func filterErrors(errors:[FieldKey:[InstagramCloneExceptions]])->[FieldKey:[InstagramCloneExceptions]]{
        return errors.filter { !$0.value.isEmpty }
    }
}
