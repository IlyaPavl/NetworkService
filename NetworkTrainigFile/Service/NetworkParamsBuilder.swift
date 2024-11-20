//
//  NetworkParamsBuilder.swift
//  NetworkTrainigFile
//
//  Created by Илья Павлов on 31.10.2024.
//

protocol NetworkParamsBuilderProtocol {
    func setParameter(_ key: String, value: Any) -> Self
    func setParameters(_ params: [String: Any]?) -> Self
    func build() -> [String: String]
    func buildBody() -> [String: Any]
}

class NetworkParamsBuilder: NetworkParamsBuilderProtocol {
    private var params: [String: Any] = [:]
    private var bodyParams: [String: Any] = [:]
    
    func setParameter(_ key: String, value: Any) -> Self {
        params[key] = value
        return self
    }
    
    func setParameters(_ params: [String: Any]?) -> Self {
        guard let params else { return self }
        params.forEach { self.params[$0.key] = $0.value }
        return self
    }
    
    func build() -> [String: String] {
        var result: [String: String] = [:]
        
        for (key, value) in params {
            if let arrayValue = value as? [String] {
                result[key] = arrayValue.joined(separator: ",")
            } else if let boolValue = value as? Bool {
                result[key] = boolValue ? "true" : "false"
            } else {
                result[key] = "\(value)"
            }
        }
        return result
    }
    
    func buildBody() -> [String: Any] {
           return bodyParams
       }
}
