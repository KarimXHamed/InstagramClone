//
//  Endpoint.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//

import Foundation
protocol Endpoint {
    
        var baseURL: URL { get }
        var path: String { get }
        var parameters: [FieldKey: Any]? {get}
        var headers: [FieldKey: String]? { get }
        var credentials: String? { get }
        var timeout:TimeInterval? {get}
        var queryItems:[FieldKey:String]? {get}
        func buildBody()->[FieldKey: Any]
        
}
