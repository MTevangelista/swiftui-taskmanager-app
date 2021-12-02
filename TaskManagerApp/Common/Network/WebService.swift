//
//  WebService.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 26/07/21.
//

import Foundation

enum WebService {
    public static func call<T: Encodable>(path: String,
                                          method: HttpMethod = .get,
                                          body: T, completion: @escaping (Result) -> Void) {
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        
        handleCallRequest(path: path, method: method, contentType: .json, data: jsonData, completion: completion)
    }
    
    public static func call(path: String,
                            method: HttpMethod = .get,
                            completion: @escaping (Result) -> Void) {
        handleCallRequest(path: path, method: method, contentType: .json, data: nil, completion: completion)
    }
    
    public static func call<T: Encodable>(path: Endpoint,
                                          method: HttpMethod = .get,
                                          body: T,
                                          completion: @escaping (Result) -> Void) {
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        
        handleCallRequest(path: path.rawValue, method: method, contentType: .json, data: jsonData, completion: completion)
    }
    
    public static func call(path: Endpoint,
                            method: HttpMethod = .get,
                            completion: @escaping (Result) -> Void) {
        handleCallRequest(path: path.rawValue, method: method, contentType: .json, data: nil, completion: completion)
    }
    
    public static func call(path: Endpoint,
                            method: HttpMethod = .post,
                            params: [URLQueryItem],
                            data: Data? = nil,
                            completion: @escaping (Result) -> Void) {
        guard let urlRequest = completeURL(path: path.rawValue) else { return }
        guard let absoluteURL = urlRequest.url?.absoluteString else { return }
        let boundary = "Boundary-\(NSUUID().uuidString)" // generates a random string
        var components = URLComponents(string: absoluteURL)
        
        components?.queryItems = params
        handleCallRequest(path: path.rawValue,
                          method: method,
                          contentType: data != nil ? .multipart : .formUrl,
                          data: data != nil ? createBodyWithParameters(params: params, data: data!, boundary: boundary) : components?.query?.data(using: .utf8),
                          boundary: boundary,
                          completion: completion)
    }
}

extension WebService {
    enum Endpoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        
        case postUser = "/users"
        case fetchUser = "/users/me"
        case updateUser = "/users/%d"
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
        case multipart = "multipart/form-data"
    }
}

extension WebService {
    private static func completeURL(path: String) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path)") else { return nil }
        
        return URLRequest(url: url)
    }
    
    private static func handleCallRequest(path: String,
                                          method: HttpMethod,
                                          contentType: ContentType,
                                          data: Data?,
                                          boundary: String = "",
                                          completion: @escaping (Result) -> Void) {
        guard var urlRequest = completeURL(path: path) else { return }
        
        _ = LocalDataSource.shared.getUserAuth()
            .sink { userAuth in
                if let userAuth = userAuth {
                    urlRequest.setValue("\(userAuth.tokenType) \(userAuth.idToken)", forHTTPHeaderField: "Authorization")
                }
                
                contentType == .multipart
                    ? urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
                    : urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "content-Type")
                
                urlRequest.httpMethod = method.rawValue
                urlRequest.setValue("application/json", forHTTPHeaderField: "accept")
                urlRequest.httpBody = data
                
                let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    guard let data = data, error == nil else {
                        print(error ?? "")
                        completion(.failure(.internalServerError, nil))
                        return
                    }
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        switch httpResponse.statusCode {
                        case 200, 201:
                            completion(.success(data))
                            break
                        case 400:
                            completion(.failure(.badRequest, data))
                            break
                        case 401:
                            completion(.failure(.unauthorized, data))
                        default:
                            break
                        }
                    }
                }
                task.resume()
            }
    }
    
    private static func createBodyWithParameters(params: [URLQueryItem], data: Data, boundary: String) -> Data {
        let body = NSMutableData()
        let filename = "img.jpg"
        let mimeType = "image/jpeg"
        
        for param in params {
            body.appendString("--\(boundary)\r\n")
            body.appendString("Content-Disposition: form-data; name=\"\(param.name)\"\r\n\r\n")
            body.appendString("\(param.value!)\r\n")
        }
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        
        body.appendString("--\(boundary)--\r\n")
        return body as Data
    }
}
