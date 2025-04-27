//
//  ReelsRequest.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Foundation
struct ReelsRequest:Endpoint {
    var baseURL: URL {
        return URL(string: "https://api.pexels.com")!
    }
    
    var path: String = "/videos/popular"
    
    var parameters: [FieldKey : Any]?
    
    var headers: [FieldKey : String]? {
        return [
            .Authorization : "FxEhMfjdRztCKAJjFMKXABtjz05JJUN3icPsFXxqGUuciHakuQeP3O4Y"
        ]
    }
    
    var timeout: TimeInterval?
    
    var queryItems: [FieldKey : String]?
    
    func buildBody() -> [FieldKey : Any] {
        return [:]
    }
    
    var credentials: String?
    
}
extension ReelsRequest:RequestValidation {
    func getHeaders() -> [FieldKey : String] {
        guard let headers = headers else {return [:] }
        return headers
    }
    
    func getBody() -> [FieldKey : Any] {
        guard let body = parameters else {return [:] }
        return body
    }
    
    func getQueries() -> [FieldKey : String] {
        guard let queries = queryItems else {return [:] }
        return queries
    }
    
    func getRequestContract() -> [RequiredContractType : [FieldKey : Bool]] {
        return [
            .headers:[.Authorization:true]
        ]
    }
    
    func validateFieldData(_field: FieldKey, value: Any) -> [InstagramCloneExceptions]? {
        var errors : [InstagramCloneExceptions] = []
        let validator = InputValidator()
        switch _field {
        case .Authorization:
            if let error = validator.validateStringFieldKey(string:value as! String, fieldKey: _field.rawValue) {
                errors.append(error)
            }
        default:
            break
        }
        return errors
    }
}
