//
//  NetworkService.swift
//  NetworkTrainigFile
//
//  Created by Илья Павлов on 31.10.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(apiHost: APIHost,
                               endpoint: Endpoint,
                               method: HTTPMethodType,
                               parameters: NetworkParamsBuilderProtocol?,
                               headers: [String: String]?,
                               completion: @escaping (Result<T, APIError>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    static let shared = NetworkService()
    private init() {}
    
    func request<T: Decodable>(apiHost: APIHost,
                               endpoint: Endpoint,
                               method: HTTPMethodType,
                               parameters: NetworkParamsBuilderProtocol? = nil,
                               headers: [String : String]?,
                               completion: @escaping (Result<T, APIError>) -> Void) {
        let hostProvider = HostFactory.createHost(for: apiHost)
        
        guard let url = URLFactory.buildURL(from: endpoint, hostProvider: hostProvider) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if method != .get, let bodyParams = parameters?.buildBody() {
            request.httpBody = try? JSONSerialization.data(withJSONObject: bodyParams)
        }
        
        let task = createDataTask(from: request) { data, response, error in
            if let _ = error {
                completion(.failure(APIError.invalidRequest))
                return
            }
            guard let data = data else {
                completion(.failure(APIError.invalidResponse))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedObject = try decoder.decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(APIError.decodingError))
            }
        }
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest,
                                completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
        }
    }
}
