//
//  NetworkDataFetcher.swift
//  NetworkTrainigFile
//
//  Created by Илья Павлов on 31.10.2024.
//

protocol NetworkDataFetcherProtocol {
    func getCountries(from responseModel: @escaping (Countries?) -> Void)
    func getCountryByName(name: String, fullText: Bool, from responseModel: @escaping (Countries?) -> Void)
    func getIndependentCountries(status: Bool, fields: [String]?, from responseModel: @escaping (Countries?) -> Void)
}

struct NetworkDataFetcher: NetworkDataFetcherProtocol {
    let networkService: NetworkServiceProtocol
    
    func getCountries(from responseModel: @escaping (Countries?) -> Void) {
        let endpoint = RestCountriesAPI.all
        let apiHost: APIHost = .restCountries
        
        let parameters = NetworkParamsBuilder()
            .setParameters(endpoint.queryParams)
        
        networkService.request(
            apiHost: apiHost,
            endpoint: endpoint,
            method: .get,
            parameters: parameters,
            headers: nil) { (result: Result<Countries, APIError>) in
                switch result {
                    case .success(let countries):
                        responseModel(countries)
                    case .failure:
                        responseModel(nil)
                }
            }
    }
    
    func getCountryByName(name: String, fullText: Bool, from responseModel: @escaping (Countries?) -> Void) {
        let endpoint = RestCountriesAPI.countryByName(name: name, fullText: fullText)
        let apiHost: APIHost = .restCountries
        
        let parameters = NetworkParamsBuilder()
            .setParameters(endpoint.queryParams)
        
        networkService.request(apiHost: apiHost, endpoint: endpoint, method: .get, parameters: parameters, headers: nil) { (result: Result<Countries, APIError>) in
                switch result {
                    case .success(let countries):
                        if countries.count == 1 {
                            responseModel(countries)
                        } else {
                            responseModel(nil)
                        }
                    case .failure(_):
                        responseModel(nil)
                }
            }
    }
    
    func getIndependentCountries(status: Bool, fields: [String]?, from responseModel: @escaping (Countries?) -> Void) {
        let endpoint = RestCountriesAPI.independent(status: status, fields: fields)
        let apiHost: APIHost = .restCountries
        
        let parameters = NetworkParamsBuilder()
            .setParameters(endpoint.queryParams)
        
        networkService.request(apiHost: apiHost, endpoint: endpoint, method: .get, parameters: parameters, headers: nil) { (result: Result<Countries, APIError>) in
                switch result {
                    case .success(let countries):
                        responseModel(countries)
                    case .failure:
                        responseModel(nil)
                }
            }
    }
}
