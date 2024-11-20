//
//  URLFactory.swift
//  NetworkTrainigFile
//
//  Created by Илья Павлов on 31.10.2024.
//

import Foundation

class URLFactory {
    static func buildURL(from endpoint: Endpoint, hostProvider: HostProvider) -> URL? {
        var components = URLComponents()
        components.scheme = hostProvider.scheme
        components.host = hostProvider.host
        components.path = endpoint.path
        
        if let queryParams = endpoint.queryParams {
            components.queryItems = queryParams.map { key, value in
                if let arrayValue = value as? [String] {
                    return URLQueryItem(name: key, value: arrayValue.joined(separator: ","))
                } else if let boolValue = value as? Bool {
                    return URLQueryItem(name: key, value: boolValue ? "true" : "false")
                } else {
                    return URLQueryItem(name: key, value: "\(value)")
                }
            }
        }
        
        return components.url
    }
}
