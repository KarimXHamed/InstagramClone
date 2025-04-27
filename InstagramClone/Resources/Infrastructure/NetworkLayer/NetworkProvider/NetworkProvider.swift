//
//  AsyncNetworkProvider.swift
//  SolutionX
//
//  Created by mayar on 03/02/2025.
//

import Foundation
import Factory
import Alamofire

class AlamofireNetworkProvider: NetworkProviderProtocol {
    
    @Injected(\.responseHandler) private var responseHandler: AlamofireResponseHandler
    
    private var session: Session
    
    init(session: Session = .default) {
        self.session = session
        
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        self.session = Session(configuration: configuration)
    }
    
    // MARK: - Public Interface
    
    func get<T: Codable>(endpoint: EndpointProtocol, model: T.Type) async throws -> T {
        try await performRequest(endpoint: endpoint, method: .get, model: model)
    }
    
    func post<T: Codable>(endpoint: EndpointProtocol, model: T.Type) async throws -> T {
        if endpoint.dataToUpload != nil {
            return try await uploadData(endpoint: endpoint, model: model)
        }
        return try await performRequest(endpoint: endpoint, method: .post, model: model)
    }
    
    func put<T: Codable>(endpoint: EndpointProtocol, model: T.Type) async throws -> T {
        if endpoint.dataToUpload != nil {
            return try await uploadData(endpoint: endpoint, model: model)
        }
        return try await performRequest(endpoint: endpoint, method: .put, model: model)
    }
    
    func delete<T: Codable>(endpoint: EndpointProtocol, model: T.Type) async throws -> T {
        try await performRequest(endpoint: endpoint, method: .delete, model: model)
    }
    
    // MARK: - Private Request Handling
    
    private func performRequest<T: Codable>(
        endpoint: EndpointProtocol,
        method: HTTPMethod,
        model: T.Type
    ) async throws -> T {
        let request = prepareRequest(endpoint: endpoint, method: method)
        
        return try await withCheckedThrowingContinuation { continuation in
            request
                .validate()
                .responseData { [weak self] response in
                    guard let self = self else { return }
                    do {
                        let decodedResponse = try self.responseHandler.handleResponse(response, model: T.self)
                        continuation.resume(returning: decodedResponse)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
    
    func uploadData<T: Codable>(endpoint: EndpointProtocol, model: T.Type ) async throws -> T {
        let (urlRequest, multipartData) = try prepareMultipartUpload(endpoint: endpoint)
        return try await performUpload(urlRequest: urlRequest, multipartData: multipartData, model: model)
    }
    
    private func performUpload<T: Codable>( urlRequest: URLRequest, multipartData: MultipartFormData, model: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            session.upload(
                multipartFormData: multipartData,
                with: urlRequest
            )
            .validate()
            .responseData { [weak self] response in
                guard let self = self else { return }
                do {
                    let decodedResponse = try self.responseHandler.handleResponse(response, model: T.self)
                    continuation.resume(returning: decodedResponse)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
extension AlamofireNetworkProvider {
    
    // MARK: - Request Preparation
    
    private func prepareRequest( endpoint: EndpointProtocol, method: HTTPMethod ) -> DataRequest {
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        let parameters = endpoint.parameters ?? endpoint.buildBody()
        let encoding: ParameterEncoding = method == .get ? URLEncoding.default : JSONEncoding.default
        let headers = convertToHTTPHeaders(endpoint.headers)

        if let timeout = endpoint.timeout {
            session.sessionConfiguration.timeoutIntervalForRequest = timeout
        }
        
        return session.request(
            url,
            method: method,
            parameters: convertParameters(parameters),
            encoding: encoding,
            headers: headers
        )
    }
    
    private func prepareMultipartUpload( endpoint: EndpointProtocol) throws -> (URLRequest, MultipartFormData) {
        guard let data = endpoint.dataToUpload else {
            throw AltasheratExceptions.remote(.noDataToUpload)
        }
        
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        var headers = convertToHTTPHeaders(endpoint.headers)
        if let credentials = endpoint.credentials {
            headers.add(.authorization(bearerToken: credentials))
        }
        urlRequest.allHTTPHeaderFields = headers.dictionary

        let formData = MultipartFormData()
        let fileName = endpoint.fileName ?? "file_\(Date().timeIntervalSince1970).jpg"
        let mimeType = endpoint.headers?[.contentType] ?? "application/octet-stream"
        
        formData.append(data, withName: endpoint.fileName ?? "image", fileName: fileName, mimeType: "image/jpeg")

        if let parameters = endpoint.parameters {
            for (key, value) in parameters {
                if let stringValue = value as? String,
                   let data = stringValue.data(using: .utf8) {
                    formData.append(data, withName: key.rawValue)
                }
            }
        }
        return (urlRequest, formData)
    }
    
    // MARK: - Helper Methods
    
    private func convertParameters(_ parameters: [FieldKey: Any]?) -> Parameters? {
        guard let parameters = parameters else { return nil }
        return parameters.mapKeys { $0.rawValue }
    }
    
    private func convertToHTTPHeaders(_ headers: [FieldKey: String]?) -> HTTPHeaders {
        guard let headers = headers else { return HTTPHeaders() }
        return HTTPHeaders(headers.map { HTTPHeader(name: $0.key.rawValue, value: $0.value) })
    }
}

