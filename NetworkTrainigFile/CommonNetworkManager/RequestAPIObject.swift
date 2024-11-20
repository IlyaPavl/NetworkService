//
//  RequestAPIObject.swift
//  NetworkTrainigFile
//
//  Created by Илья Павлов on 04.11.2024.
//

struct RequestAPIObject {
    let urlPath: String
    let method: HTTPMethodType
    let headers: [String: String]?
    let ruleAddingParams: RuleAddingParams?
    
    internal init(urlPath: String,
                  method: HTTPMethodType,
                  headers: [String: String]?,
                  ruleAddingParams: RuleAddingParams?) {
        self.urlPath = urlPath
        self.method = method
        self.headers = headers
        self.ruleAddingParams = ruleAddingParams
    }
}
