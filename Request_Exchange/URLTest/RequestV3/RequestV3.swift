//
//  RequestV3.swift
//  Request_Exchange
//
//  Created by Woody Liu on 2021/2/8.
//

import Foundation
import Alamofire

protocol CostcoRequestV3 {
    var method: HTTPMethod { get }
    var apiManager: APIManager { get }
    var contentType: ContentType { get }
    var parametersEncoding: ParameterEncoding? { get }
    var decisions: [Decision] { get }
}

extension CostcoRequestV3 {
    
    func buildRequest(domin: String, memberId: String, guid: String, authToken: String)-> DataRequest {
        let endpoint: String = apiManager.endPoint(memberId: memberId, guid: guid, authToken: authToken)
        let headers: HTTPHeaders? = apiManager.headers(memberId: memberId, guid: guid, authToken: authToken)
        let parameters: Parameters? = apiManager.parameters(memberId: memberId, guid: guid, authToken: authToken)
        
        let urlString = domin + endpoint
        
        return contentType.buildRequest(urlString, method: method, parameters: parameters, encoding: parametersEncoding ?? JSONEncoding.default, headers: headers)
    }
    
}


struct BaseRequestV3: CostcoRequestV3 {
    
    var method: HTTPMethod
    
    var apiManager: APIManager
    
    var contentType: ContentType
    
    var parametersEncoding: ParameterEncoding?
    
    var decisions: [Decision]
    
    
}
