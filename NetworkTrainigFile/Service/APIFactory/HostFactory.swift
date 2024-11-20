//
//  API.swift
//  NetworkTrainigFile
//
//  Created by Илья Павлов on 31.10.2024.
//

protocol HostProvider {
    var scheme: String { get }
    var host: String { get }
}

public enum APIHost: HostProvider {
    case restCountries
    
    var scheme: String {
        switch self {
            case .restCountries:
                return "https"
        }
    }
    
    var host: String {
        switch self {
            case .restCountries:
                return "restcountries.com"
        }
    }
}

class HostFactory {
    static func createHost(for apiHost: APIHost) -> HostProvider {
        return apiHost
    }
}
