//
//  WebService.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 26/07/21.
//

import Foundation

enum WebService {
    public static func call<T: Encodable>(path: String, method: HttpMethod = .get, body: T, completion: @escaping (Result) -> Void) {
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        
        handleCallRequest(path: path, method: method, contentType: .json, data: jsonData, completion: completion)
    }
    
    public static func call<T: Encodable>(path: Endpoint, method: HttpMethod = .get, body: T, completion: @escaping (Result) -> Void) {
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        
        handleCallRequest(path: path.rawValue, method: method, contentType: .json, data: jsonData, completion: completion)
    }
    
    public static func call(path: Endpoint, method: HttpMethod = .get, completion: @escaping (Result) -> Void) {
        handleCallRequest(path: path.rawValue, method: method, contentType: .json, data: nil, completion: completion)
    }
    
    public static func call(path: Endpoint, method: HttpMethod = .post, params: [URLQueryItem], completion: @escaping (Result) -> Void) {
        guard let urlRequest = completeURL(path: path.rawValue) else { return }
        guard let absoluteURL = urlRequest.url?.absoluteString else { return }
        var components = URLComponents(string: absoluteURL)
        components?.queryItems = params
        
        handleCallRequest(path: path.rawValue,
                          method: method,
                          contentType: .formUrl,
                          data: components?.query?.data(using: .utf8),
                          completion: completion)
    }
}

extension WebService {
    enum Endpoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        
        case postUser = "/users"
        case fetchUser = "/users/me"
        case login = "/auth/login"
        case refreshToken = "/auth/refresh-token"
        
        case habits = "/users/me/habits"
        case habitValues = "/users/me/habits/%d/values"
    }
    
    enum NetworkError {
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum Result {
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    enum HttpMethod: String {
        case get
        case post
        case put
        case delete
    }
    
    enum ContentType: String {
        case json = "application/json"
        case formUrl = "application/x-www-form-urlencoded"
    }
}

extension WebService {
    private static func completeURL(path: String) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path)") else { return nil }
        
        return URLRequest(url: url)
    }
    
    private static func handleCallRequest(path: String, method: HttpMethod, contentType: ContentType, data: Data?, completion: @escaping (Result) -> Void) {
        guard var urlRequest = completeURL(path: path) else { return }
        
        _ = LocalDataSource.shared.getUserAuth()
            .sink { userAuth in
                if let userAuth = userAuth {
                    urlRequest.setValue("\(userAuth.tokenType) \(userAuth.idToken)", forHTTPHeaderField: "Authorization")
                }
                
                urlRequest.httpMethod = method.rawValue
                urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
                urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "content-Type")
                urlRequest.httpBody = data
                
                let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    guard let data = data, error == nil else {
                        print(error ?? "")
                        completion(.failure(.internalServerError, nil))
                        return
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        switch httpResponse.statusCode {
                        case 400:
                            completion(.failure(.badRequest, data))
                            break
                        case 401:
                            completion(.failure(.unauthorized, data))
                        case 200:
                            completion(.success(data))
                            break
                        default:
                            break
                        }
                    }
                }
                task.resume()
            }
    }
}
