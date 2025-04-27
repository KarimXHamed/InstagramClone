//
//  RequestBuilder.swift
//  InstagramClone
//
//  Created by Karim Hamed  on 26/04/2025.
//
import Foundation
struct RequestBuilder {
    private var urlComponents: URLComponents?
    private var urlRequest: URLRequest?

    // MARK: - Configure base URL and path
    private func setBaseURL(_ baseURL: URL?, path: String?) {
        guard let baseURL = baseURL, let path = path else { return }
        self.urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        if let finalURL = urlComponents?.url {
            self.urlRequest = URLRequest(url: finalURL)
        }
    }
    
    // MARK: - Configure HTTP method
    private func setMethod(_ method: HTTPMethod?) {
        guard let method = method else { return }
        self.urlRequest?.method = method
    }

    // MARK: - Add Query Parameters
    private func addQueryItems(_ queryItems: [FieldKey: String]?) {
        guard let queryItems = queryItems else { return }
        let queryArray = queryItems.map { URLQueryItem(name: $0.rawValue, value: $1) }
        
        if self.urlComponents?.queryItems == nil {
            self.urlComponents?.queryItems = queryArray
        } else {
            self.urlComponents?.queryItems?.append(contentsOf: queryArray)
        }
    }

    // MARK: - Add Headers
    private func addHeaders(_ headers: [FieldKey: String]?) {
        guard let headers = headers else { return }
        let headerDict = Dictionary(uniqueKeysWithValues: headers.map { ($0.rawValue, $1) })
        
        self.urlRequest?.allHTTPHeaderFields = headerDict
    }

    // MARK: - Set Request Body
    private func setBody(_ parameters: [FieldKey: Any]?, method: HTTPMethod?) {
        guard let method = method, method != .get else { return }
        guard let parameters = parameters else { return }
        
        let bodyDict = Dictionary(uniqueKeysWithValues: parameters.map { ($0.rawValue, $0.value) })
        self.urlRequest?.httpBody = try? JSONSerialization.data(withJSONObject: bodyDict, options: .fragmentsAllowed)
    }

    // MARK: - Set Timeout
    private func setTimeout(_ timeout: TimeInterval?) {
        guard let timeout = timeout else { return }
        self.urlRequest?.timeoutInterval = timeout
    }

    // MARK: - Set Authorization Header
    private func setCredentials(_ credentials: String?) {
        guard let credentials = credentials else { return }
        self.urlRequest?.setValue("Basic \(credentials)", forHTTPHeaderField: "Authorization")
    }
    
    // MARK: - Build Final URLRequest
    func makeRequest(endpoint: Endpoint, method: HTTPMethod) throws -> URLRequest {
        setBaseURL(endpoint.baseURL, path: endpoint.path)
        setMethod(method)
        setTimeout(endpoint.timeout)
        setCredentials(endpoint.credentials)
        addHeaders(endpoint.headers)
        setBody(endpoint.buildBody(), method: method)
        addQueryItems(endpoint.queryItems)
        
        guard let finalURL = urlComponents?.url else {
            throw URLError(.badURL)
        }
        
        self.urlRequest?.url = finalURL
        return self.urlRequest!
    }
}

