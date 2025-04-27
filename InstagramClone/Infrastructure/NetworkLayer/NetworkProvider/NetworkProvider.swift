//
//  NetworkProvider.swift
//  InstagramCLone
//
//  Created by Karim Hamed on 26/04/2025.
//
import Factory
import Alamofire

class NetworkProvider: NetworkProviderProtocol {
 
    
    @Injected(\.responseHandler) private var responseHandler:ResponseHandler
    
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
    
    func request<T:Codable>(endpoint: Endpoint,method:HTTPMethods) async throws -> T {
        let urlRequest = RequestBuilder.makeRequest(endpoint: endpoint, method:method)
        
        let response = AF.request(urlRequest)
            .validate()
            .cURLDescription { description in
                print(description)
            }
            .serializingDecodable(T.self)
            .response
        
        debugPrint(response)
        
        switch response.result {
        case .success(let data):
            guard let httpResponse = response.response else {
                throw InstagramCloneExceptions.remote(.unknownError(statusCode: nil, message: "Invalid HTTP response"))
            }
            return try responseHandler.handleError(httpResponse: httpResponse, data: data, model: T.self)
            
        case .failure(let error):
            throw InstagramCloneExceptions.remote(.unknownError(statusCode: nil, message: error))
        }
    }
}


