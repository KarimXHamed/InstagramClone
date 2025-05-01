//
//  NetworkProviderProtocol.swift
//  InstagreamClone
//
//  Created by Karim Hamed on 26/04/2025.
//

import Foundation

protocol NetworkProviderProtocol{

    func get<T: Codable>(endpoint:Endpoint,model:T.Type) async throws -> T
    func post<T: Codable>(endpoint:Endpoint,model:T.Type) async throws -> T
    func put<T: Codable>(endpoint:Endpoint,model:T.Type) async throws -> T
    func delete<T: Codable>(endpoint:Endpoint,model:T.Type) async throws -> T
    func request<T: Codable>(endpoint: Endpoint,method:HTTPMethods) async throws -> T 

}
