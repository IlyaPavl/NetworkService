//
//  CountriesService.swift
//  NetworkTrainigFile
//
//  Created by Илья Павлов on 02.11.2024.
//

protocol CountriesServiceProtocol {
    func fetchCountries(completion: @escaping (Result<Countries, Error>) -> Void)
    func fetchCountryBy(name: String, fullText: Bool, completion: @escaping (Result<Countries, Error>) -> Void)
    func fetchCountryBy(codes: [String], completion: @escaping (Result<Countries, Error>) -> Void)
    func fetchFields(for service: String, fields: [String], completion: @escaping (Result<Countries, Error>) -> Void)
}

class CountriesService {
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = CommonNetworkManager.shared) {
        self.networkManager = networkManager
    }
}

extension CountriesService: CountriesServiceProtocol {
    func fetchCountries(completion: @escaping (Result<Countries, Error>) -> Void) {
        guard let dto: RequestDTO = RequestBuilderAPI.init(requestType: .all).build() else { return }
        
        networkManager.makeRequest(with: dto) { (result: Result<Countries, APIError>) in
            self.handleRequest(result, completion: completion)
        }
    }
    
    func fetchCountryBy(name: String, fullText: Bool, completion: @escaping (Result<Countries, Error>) -> Void) {
        let params: [String: Any] = ["fullText": fullText]
        let urlPathParams = name
        
        guard let dto: RequestDTO = RequestBuilderAPI(requestType: .countryByName)
            .build(params: params, urlPathParams: urlPathParams) else {
            return
        }
        networkManager.makeRequest(with: dto) { (result: Result<Countries, APIError>) in
            self.handleRequest(result, completion: completion)
        }
    }
    
    func fetchCountryBy(codes: [String], completion: @escaping (Result<Countries, any Error>) -> Void) {
        let codesQuery = codes.joined(separator: ",")
        let params: [String: Any] = ["codes": codesQuery]
        
        guard let dto: RequestDTO = RequestBuilderAPI(requestType: .countryByAlpha)
            .build(params: params) else {
            return
        }
        
        networkManager.makeRequest(with: dto) { (result: Result<Countries, APIError>) in
            self.handleRequest(result, completion: completion)
        }
    }
    
    func fetchFields(for service: String, fields: [String], completion: @escaping (Result<Countries, Error>) -> Void) {
        let params: [String: Any] = ["fields": fields.joined(separator: ",")]
        
        guard let dto: RequestDTO = RequestBuilderAPI(requestType: .fields)
            .build(params: params, urlPathParams: service) else {
            return
        }
        
        CommonNetworkManager.shared.makeRequest(with: dto) { (result: Result<Countries, APIError>) in
            switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

extension CountriesService {
    private func handleRequest<T>(_ result: Result<T, APIError>, completion: @escaping (Result<T, Error>) -> Void) {
        switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
        }
    }
}
