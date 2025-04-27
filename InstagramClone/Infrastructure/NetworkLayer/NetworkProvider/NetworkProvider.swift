//
//  NetworkProvider.swift
//  InstagramCLone
//
//  Created by Karim Hamed on 26/04/2025.
//
import Factory
import Alamofire
import Foundation

class NetworkProvider: NetworkProviderProtocol {
 
    
    
    func get<T:Codable>(endpoint: any Endpoint, model: T.Type) async throws -> T  {
        return try await request(endpoint: endpoint, method: HTTPMethods.get)
    }
    
    func post<T:Codable>(endpoint: any Endpoint, model: T.Type) async throws -> T  {
        return try await request(endpoint: endpoint, method: HTTPMethods.post)
        
    }
    
    func put<T:Codable>(endpoint: any Endpoint, model: T.Type) async throws -> T{
        return try await request(endpoint: endpoint, method: HTTPMethods.put)
        
    }
    
    func delete<T:Codable>(endpoint: any Endpoint, model: T.Type) async throws -> T{
        return try await request(endpoint: endpoint, method: HTTPMethods.delete)
        
    }
    
    func request<T: Codable>(endpoint: Endpoint, method: HTTPMethods) async throws -> T {
        var requestBuilder = RequestBuilder()
        let urlRequest = try requestBuilder.makeRequest(endpoint: endpoint, method: method.rawValue)
        
        let response = await AF.request(urlRequest)
            .validate(statusCode: 200..<300)
            .cURLDescription { description in
                print(description)
            }
            .serializingDecodable(T.self)
            .response
        
        debugPrint(response)
        
        switch response.result {
        case .success(let model):
            return model
            
        case .failure(let error):
            throw InstagramCloneExceptions.remote(.unknownError(statusCode: nil, message: error.errorDescription))
        }
    }
    }



