//
//  APIManager.swift
//  NetworkTrainigFile
//
//  Created by Илья Павлов on 04.11.2024.
//

import Foundation

protocol ApiManagerInterface {
    func requestApiObj(requestType: RequestType, urlPathParam: Any?) throws -> RequestAPIObject
}

struct APIManager: ApiManagerInterface {
    
    func requestApiObj(requestType: RequestType, urlPathParam: Any?) throws -> RequestAPIObject {
        var urlWithPath: String?
        let baseUrl = "https://restcountries.com"
        let httpMethod: HTTPMethodType = .get
        let headers: [String: String]? = nil
        var ruleAddingParams: RuleAddingParams?
        
        switch requestType {
            case .all:
                urlWithPath = "\(baseUrl)/v3.1/all"
                ruleAddingParams = .addToUrl
                
            case .independent:
                urlWithPath = "\(baseUrl)/v3.1/independent"
                ruleAddingParams = .addToUrl
                
            case .countryByName:
                guard let name = urlPathParam as? String else { throw APIError.invalidRequest }
                urlWithPath = "\(baseUrl)/v3.1/name/\(name)"
                ruleAddingParams = .addToUrl
                
            case .countryByAlpha:
                urlWithPath = "\(baseUrl)/v3.1/alpha"
                ruleAddingParams = .addToUrl
                
            case .currency:
                guard let currency = urlPathParam as? String else { throw APIError.invalidRequest }
                urlWithPath = "\(baseUrl)/v3.1/currency/\(currency)"
                ruleAddingParams = .addToUrl
                
            case .demonym:
                guard let demonym = urlPathParam as? String else { throw APIError.invalidRequest }
                urlWithPath = "\(baseUrl)/v3.1/demonym/\(demonym)"
                ruleAddingParams = .addToUrl
                
            case .language:
                guard let language = urlPathParam as? String else { throw APIError.invalidRequest }
                urlWithPath = "\(baseUrl)/v3.1/lang/\(language)"
                ruleAddingParams = .addToUrl
                
            case .capital:
                guard let capital = urlPathParam as? String else { throw APIError.invalidRequest }
                urlWithPath = "\(baseUrl)/v3.1/capital/\(capital)"
                ruleAddingParams = .addToUrl
                
            case .region:
                guard let region = urlPathParam as? String else { throw APIError.invalidRequest }
                urlWithPath = "\(baseUrl)/v3.1/region/\(region)"
                ruleAddingParams = .addToUrl
                
            case .subregion:
                guard let subregion = urlPathParam as? String else { throw APIError.invalidRequest }
                urlWithPath = "\(baseUrl)/v3.1/subregion/\(subregion)"
                ruleAddingParams = .addToUrl
                
            case .translation:
                guard let translation = urlPathParam as? String else { throw APIError.invalidRequest }
                urlWithPath = "\(baseUrl)/v3.1/translation/\(translation)"
                ruleAddingParams = .addToUrl
            case .fields:
                guard let service = urlPathParam as? String else { throw APIError.invalidRequest }
                urlWithPath = "\(baseUrl)/v3.1/\(service)"
                ruleAddingParams = .addToUrl
        }
        
        guard let urlWithPath else {
            throw APIError.invalidRequest
        }
        
        let requestObject = RequestAPIObject(
            urlPath: urlWithPath,
            method: httpMethod,
            headers: headers,
            ruleAddingParams: ruleAddingParams
        )
        
        return requestObject
    }
}
