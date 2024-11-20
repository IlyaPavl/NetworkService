//
//  RequestBuilder.swift
//  NetworkTrainigFile
//
//  Created by Илья Павлов on 02.11.2024.
//

import Foundation

public struct RequestDTO {
    private(set) var url: String
    private(set) var httpMethod: HTTPMethodType
    private(set) var requestType: RequestType?
    private(set) var headers: [String: String]?
    private(set) var params: Any?
    private(set) var ruleAddingParams: RuleAddingParams?
}

public struct RequestBuilderAPI {
    public init(requestType: RequestType) {
        self.requestType = requestType
    }
    private let requestType: RequestType
    
    public func build(params: Any? = nil, urlPathParams: Any? = nil) -> RequestDTO? {
        do {
            let requestObject = try APIManager().requestApiObj(requestType: requestType, urlPathParam: urlPathParams)
            let resultDTO = RequestBuilderManual(url: requestObject.urlPath, httpMethod: requestObject.method)
                .set(params: params)
                .set(headers: requestObject.headers)
                .set(requestType: requestType)
                .set(ruleAddingParams: requestObject.ruleAddingParams)
                .build()
            return resultDTO
        } catch {
            assertionFailure("ANApiManager error")
            return nil
        }
    }
}

final class RequestBuilderManual {
    init(url: String, httpMethod: HTTPMethodType) {
        self.url = url
        self.httpMethod = httpMethod
    }
    
    private var url: String
    private var httpMethod: HTTPMethodType
    private(set) var requestType: RequestType?
    private var headers: [String: String]?
    private var params: Any?
    private var ruleAddingParams: RuleAddingParams?
    
    func build() -> RequestDTO {
        let dto = RequestDTO(
            url: url,
            httpMethod: httpMethod,
            requestType: requestType,
            headers: headers,
            params: params,
            ruleAddingParams: ruleAddingParams
        )
        return dto
    }
}

extension RequestBuilderManual {
    func set(headers: [String: String]?) -> RequestBuilderManual {
        self.headers = headers
        return self
    }
    
    func set(params: Any?) -> RequestBuilderManual {
        self.params = params
        return self
    }
    
    func set(requestType: RequestType?) -> RequestBuilderManual {
        self.requestType = requestType
        return self
    }
    
    func set(ruleAddingParams: RuleAddingParams?) -> RequestBuilderManual {
        self.ruleAddingParams = ruleAddingParams
        return self
    }
}
