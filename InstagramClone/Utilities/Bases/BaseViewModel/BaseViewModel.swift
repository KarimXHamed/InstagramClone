//
//  BaseViewModel.swift
//  InstagramClone
//
//  Created by Karim Hamed on 24/06/2025.
//

import Foundation
import UIKit
import Combine

class BaseViewModel: BaseViewModelProtocol {

    @Published var reloadData: Bool = false
    @Published var error: String? = nil
    @Published var loading: Bool = true

    var shouldReloadPublisher: Published<Bool>.Publisher { $reloadData }
    var loadingPublisher: Published<Bool>.Publisher { $loading }
    var errorPublisher: Published<String?>.Publisher { $error }

    var cancellables = Set<AnyCancellable>()
    
     func onFailure(failure:InstagramCloneExceptions){
        switch failure {
        case .remote(let remoteError):
            error = remoteError.errorDescription
        case .validationError(.fieldErrors(let validationErrors)):
            handleValidationErrors(error: validationErrors)
        default:
            break
        }
   
    }

    func handleRequestValidation(error:InstagramCloneExceptions.RequestValidationError){
        print(error.errorDescription as Any)
    }
    func handleInputValidationError(error:InstagramCloneExceptions.InputValidationError){}
    func handleValidationErrors(error:[FieldKey:[InstagramCloneExceptions]]){}
    func joinErrors(errors:[InstagramCloneExceptions])->String{
        return errors.map {$0.localizedDescription}.joined(separator: "\n")
         
    }

}
