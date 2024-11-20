//
//  NetworkManager.swift
//  NetworkTrainigFile
//
//  Created by Илья Павлов on 02.11.2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func makeRequest<T: Decodable>(with dto: RequestDTO, completion: @escaping (Result<T, APIError>) -> Void)
}

public final class CommonNetworkManager: NetworkManagerProtocol {
    
    private init() {}
    public static let shared = CommonNetworkManager()
    
    public func makeRequest<T: Decodable>(with dto: RequestDTO, completion: @escaping (Result<T, APIError>) -> Void) {
        guard let url = URL(string: dto.url) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = dto.httpMethod.rawValue
        request.allHTTPHeaderFields = dto.headers
        request = addParams(to: request, from: dto)
        
        let task = URLSession.shared.dataTask(with: request) { data, request, error in
            DispatchQueue.main.async {
                if let _ = error {
                    completion(.failure(APIError.invalidRequest))
                    return
                }
                guard let data = data else {
                    completion(.failure(APIError.invalidData))
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
        }
        task.resume()
    }
    
    private func addParams(to request: URLRequest, from dto: RequestDTO) -> URLRequest {
        var updatedRequest = request
        guard let params = dto.params as? [String: Any] else { return updatedRequest }
        
        if let rules = dto.ruleAddingParams {
            switch rules {
                case .addToUrl:
                    if var urlComponents = URLComponents(string: dto.url) {
                        urlComponents.queryItems = params.map { key, value in
                            URLQueryItem(name: key, value: "\(value)")
                        }
                        if let updatedURL = urlComponents.url {
                            updatedRequest.url = updatedURL
                        }
                    }
                    
                case .addToBody:
                    do {
                        updatedRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
                        updatedRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                    } catch {
                        print("Failed to serialize JSON parameters: \(error)")
                    }
            }
        }
        return updatedRequest
    }
}
