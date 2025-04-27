//
//  BaseViewModel.swift
//  AlTasherat-IOS-G2-T1
//
//  Created by mayar on 13/03/2025.
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
    
     func onFailure(failure:AltasheratExceptions){
        switch failure {
        case .remote(let remoteError):
            error = remoteError.errorDescription
        case .multipleErrors(let multipleErrors):
            handleMultipleErrors(multipleErrors: multipleErrors)
        case .validationError(.fieldErrors(let validationErrors)):
            handleValidationErrors(error: validationErrors)
        default:
            break
        }
   
    }
    func handleMultipleErrors(multipleErrors:AltasheratExceptions.MultipleErrors){
        switch multipleErrors {
        case .multipleErrors(let errors):
            for error in errors {
                switch error {
                case .inputValidation(let inputValidationError):
                    handleInputValidationError(error: inputValidationError)
                case .requestValidation(let requestValidationError):
                    handleRequestValidation(error: requestValidationError)
                default:
                    break
                }
            }
        }
    }
    func handleRequestValidation(error:AltasheratExceptions.RequestValidationError){
        print(error.errorDescription as Any)
    }
    func handleInputValidationError(error:AltasheratExceptions.InputValidationError){}
    func handleValidationErrors(error:[FieldKey:[AltasheratExceptions]]){}
    func joinErrors(errors:[AltasheratExceptions])->String{
        return errors.map {$0.localizedDescription}.joined(separator: "\n")
         
    }

}
