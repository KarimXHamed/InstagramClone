//
//  AsyncNetworkProviderProtocol.swift
//  SolutionX
//
//  Created by mayar on 03/02/2025.
//

import Foundation

protocol NetworkProviderProtocol{

    func get<T: Codable>(endpoint:EndpointProtocol,model:T.Type) async throws -> T
    func post<T: Codable>(endpoint:EndpointProtocol,model:T.Type) async throws -> T
    func put<T: Codable>(endpoint:EndpointProtocol,model:T.Type) async throws -> T
    func delete<T: Codable>(endpoint:EndpointProtocol,model:T.Type) async throws -> T
    func uploadData<T: Codable>( endpoint: EndpointProtocol, model: T.Type) async throws -> T
}
