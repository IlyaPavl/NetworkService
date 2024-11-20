//
//  ParamsBuilder.swift
//  NetworkTrainigFile
//
//  Created by Илья Павлов on 31.10.2024.
//

protocol ParamsBuilderProtocol {
    func setParameter(_ key: String, value: String) -> Self
    func setParameters(_ params: [String: String]) -> Self
    func build() -> [String: String]
}

class NetworkParamsBuilder: ParamsBuilderProtocol {
    private var params: [String: String] = [:]
    
    func setParameter(_ key: String, value: String) -> Self {
        params[key] = value
        return self
    }
    
    func setParameters(_ params: [String: String]) -> Self {
        for (key, value) in params {
            self.params[key] = value
        }
        return self
    }
    
    func build() -> [String: String] {
        return params
    }
}
