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
    private mutating func setBaseURL(_ baseURL: URL?, path: String?) {
        guard let baseURL = baseURL, let path = path else { return }
        self.urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        if let finalURL = urlComponents?.url {
            self.urlRequest = URLRequest(url: finalURL)
        }
    }
    
    // MARK: - Configure HTTP method
    private mutating func setMethod(method: String?) {
       guard let method=method else {return}
       urlRequest?.httpMethod=method
   }
    // MARK: - Add Query Parameters
    private mutating func addQueryItems(_ queryItems: [FieldKey: String]?) {
        guard let queryItems = queryItems else { return }
        let queryArray = queryItems.map { URLQueryItem(name: $0.rawValue, value: $1) }
        
        if self.urlComponents?.queryItems == nil {
            self.urlComponents?.queryItems = queryArray
        } else {
            self.urlComponents?.queryItems?.append(contentsOf: queryArray)
        }
    }

    // MARK: - Add Headers
    private mutating func addHeaders(_ headers: [FieldKey: String]?) {
        guard let headers = headers else { return }
        let headerDict = Dictionary(uniqueKeysWithValues: headers.map { ($0.rawValue, $1) })
        
        self.urlRequest?.allHTTPHeaderFields = headerDict
    }

    // MARK: - Set Request Body
    private mutating func setBody(parameters: Any?,method:String?) {
        guard let parameters = parameters as? [FieldKey: Any] else { return }
        
        guard let method = method, method != HTTPMethods.get.rawValue else { return }

        let convertedParameters = Dictionary(uniqueKeysWithValues: parameters.map { ($0.rawValue, $1) })

        self.urlRequest?.httpBody = try? JSONSerialization.data(withJSONObject: convertedParameters, options: .fragmentsAllowed)
    }

    // MARK: - Set Timeout
    private mutating func setTimeout(_ timeout: TimeInterval?) {
        guard let timeout = timeout else { return }
        self.urlRequest?.timeoutInterval = timeout
    }

    // MARK: - Set Authorization Header
    private mutating func setCredentials(_ credentials: String?) {
        guard let credentials = credentials else { return }
        self.urlRequest?.setValue("Basic \(credentials)", forHTTPHeaderField: "Authorization")
    }
    
    // MARK: - Build Final URLRequest
    mutating func  makeRequest(endpoint: Endpoint, method: String) throws -> URLRequest {
        setBaseURL(endpoint.baseURL, path: endpoint.path)
        setMethod(method:method)
        setTimeout(endpoint.timeout)
        setCredentials(endpoint.credentials)
        addHeaders(endpoint.headers)
        setBody(parameters: endpoint.buildBody(), method: method)
        addQueryItems(endpoint.queryItems)
        
        guard let finalURL = urlComponents?.url else {
            throw URLError(.badURL)
        }
        
        self.urlRequest?.url = finalURL
        return self.urlRequest!
    }
}

