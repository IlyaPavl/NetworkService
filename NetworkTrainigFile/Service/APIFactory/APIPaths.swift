//
//  APIEnums.swift
//  NetworkTrainigFile
//
//  Created by Илья Павлов on 31.10.2024.
//

public protocol Endpoint {
    var path: String { get }
    var queryParams: [String: Any]? { get }
}

enum RestCountriesAPI: Endpoint {
    case all
    case independent(status: Bool, fields: [String]?)
    case countryByName(name: String, fullText: Bool)
    case countryByAlpha(codes: [String])
    case currency(currency: String)
    case demonym(demonym: String)
    case language(language: String)
    case capital(capital: String)
    case region(region: String)
    case subregion(subregion: String)
    case translation(translation: String)
    
    var path: String {
        switch self {
            case .all:
                return "/v3.1/all"
            case .independent:
                return "/v3.1/independent"
            case .countryByName(let name, _):
                return "/v3.1/name/\(name)"
            case .countryByAlpha:
                return "/v3.1/alpha"
            case .currency(let currency):
                return "/v3.1/currency/\(currency)"
            case .demonym(let demonym):
                return "/v3.1/demonym/\(demonym)"
            case .language(let language):
                return "/v3.1/lang/\(language)"
            case .capital(let capital):
                return "/v3.1/capital/\(capital)"
            case .region(let region):
                return "/v3.1/region/\(region)"
            case .subregion(let subregion):
                return "/v3.1/subregion/\(subregion)"
            case .translation(let translation):
                return "/v3.1/translation/\(translation)"
        }
    }
    
    var queryParams: [String: Any]? {
        var params: [String: String] = [:]
        
        switch self {
            case .independent(let status, let fields):
                params["status"] = String(status)
                if let fields = fields {
                    params["fields"] = fields.joined(separator: ",")
                }
            case .countryByName(_, let fullText):
                if fullText {
                    params["fullText"] = "true"
                }
            case .countryByAlpha(let codes):
                params["codes"] = codes.joined(separator: ",")
            default:
                return nil
        }
        return params
    }
}
