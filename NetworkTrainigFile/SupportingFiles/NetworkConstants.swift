//
//  NetworkConstants.swift
//  NetworkTrainigFile
//
//  Created by Илья Павлов on 04.11.2024.
//

public enum HTTPMethodType: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}

public enum APIError: Error {
    case invalidURL
    case invalidRequest
    case invalidResponse
    case invalidData
    case decodingError
}

public enum RequestType {
    case all
    case independent
    case countryByName
    case countryByAlpha
    case currency
    case demonym
    case language
    case capital
    case region
    case subregion
    case translation
}
