//
//  BaseUseCaseProtocol.swift
//  InstagramClone
//
//  Created by Karim Hamed on 24/06/2025.
//

import Foundation

protocol BaseUseCaseProtocol {
    
    func filterErrors(errors:[FieldKey:[InstagramCloneExceptions]])->[FieldKey:[InstagramCloneExceptions]]

}
