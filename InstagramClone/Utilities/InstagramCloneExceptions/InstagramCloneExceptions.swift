//
//  InstagramCloneExceptions.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Foundation
enum InstagramCloneExceptions{
    case remote(RemoteError)
    case inputValidation(InputValidationError)
    case requestValidation(RequestValidationError)
    case validationError(ValidationError)
}
extension InstagramCloneExceptions: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .remote(let error):
            return error.errorDescription
        case .inputValidation(let error):
            return error.errorDescription
        case .requestValidation(let error):
            return error.errorDescription
        case .validationError(let error):
            return error.errorDescription
        }
    }
    
    enum RemoteError: LocalizedError {
        case badRequest
        case unauthorized
        case forbidden
        case notFound
        case internalServerError
        case timeout
        case connectionFailed
        case decodingFailed
        case unknownError(statusCode: Int?, message: String?)
        
        var errorDescription: String? {
            switch self {
            case .badRequest:
                return "Bad request. Please check your input and try again."
            case .unauthorized:
                return "Unauthorized access. Please log in again."
            case .forbidden:
                return "Access forbidden. You don’t have permission."
            case .notFound:
                return "Requested resource not found."
            case .internalServerError:
                return "Server error. Please try again later."
            case .timeout:
                return "The request timed out. Please check your internet connection."
            case .connectionFailed:
                return "No internet connection. Please check your network settings."
            case .unknownError(let statusCode, let message):
                return "Unknown error (\(statusCode ?? 0)): \(message ?? "No details available.")"
 
            case .decodingFailed:
                return " Decoding failed"
            }
        }
        
        static func from(statusCode: Int, message: String? = nil) -> RemoteError {
            switch statusCode {
            case 400:
                return .badRequest
            case 401:
                return .unauthorized
            case 403:
                return .forbidden
            case 404:
                return .notFound
            case 500:
                return .internalServerError
            default:
                return .unknownError(statusCode: statusCode, message: "unknown error")
            }
        }
    }
    enum InputValidationError: LocalizedError , Equatable{
        
        
        var errorDescription: String? {
            switch self {
                
            }
        }
    }
    
    enum RequestValidationError: LocalizedError, Equatable{
        
        case nilRequiredValue(fieldKey:String)
        case emptyString(fieldKey:String)
        case missingRequiredKey(fieldKey:String)
        
        var errorDescription: String? {
            switch self {
            case .nilRequiredValue(let fieldKey):
                return"request validation error: value in \(fieldKey) is required but its nil"
            case .emptyString(let fieldKey):
                return "request validation error: value of \(fieldKey) can't be an empty string"
            case .missingRequiredKey(let fieldKey):
                return"request validation error: key \(fieldKey) is required but its missing"
            }
            
            
        }
    }
    
    enum ValidationError: LocalizedError{
        case fieldErrors([FieldKey:[InstagramCloneExceptions]])
        
    }
}

