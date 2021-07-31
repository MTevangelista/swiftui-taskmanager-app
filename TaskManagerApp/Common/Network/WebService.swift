//
//  WebService.swift
//  TaskManagerApp
//
//  Created by matheus.evangelista on 26/07/21.
//

import Foundation

enum WebService {
    public static func postUser(request: SignUpRequest, completion: @escaping (Bool?, ErrorResponse?) -> Void) {
        call(path: .postUser, body: request) { result in
            switch result {
            case .success(_):
                completion(true, nil)
                break
            case .failure(let error, let data):
                if error == .badRequest {
                    guard let data = data else { return }
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(ErrorResponse.self, from: data)
                    completion(nil, response)
                }
                break
            }
        }
    }
}

extension WebService {
    enum Endpoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        case postUser = "/users"
        case login = "/auth/login"
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
    
    enum ContentType: String {
        case json = "application/json"
        case formUrl = "application/x-www-form-urlencoded"
    }
}

extension WebService {
    private static func completeURL(path: Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path.rawValue)") else { return nil }
        
        return URLRequest(url: url)
    }
    
    private static func handleCallRequest(path: Endpoint, contentType: ContentType, data: Data?, completion: @escaping (Result) -> Void) {
        guard var urlRequest = completeURL(path: path) else { return }
        
        urlRequest.httpMethod = "POST"
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
    
    private static func call<T: Encodable>(path: Endpoint, body: T, completion: @escaping (Result) -> Void) {
        guard let jsonData = try? JSONEncoder().encode(body) else { return }
        
        handleCallRequest(path: path, contentType: .json, data: jsonData, completion: completion)
    }
    
    public static func call(path: Endpoint, params: [URLQueryItem], completion: @escaping (Result) -> Void) {
        guard let urlRequest = completeURL(path: path) else { return }
        guard let absoluteURL = urlRequest.url?.absoluteString else { return }
        var components = URLComponents(string: absoluteURL)
        components?.queryItems = params
        
        handleCallRequest(path: path,
                          contentType: .formUrl,
                          data: components?.query?.data(using: .utf8),
                          completion: completion)
    }
}
