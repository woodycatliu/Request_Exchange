//
//  RequestV2.swift
//  Request_Exchange
//
//  Created by Woody Liu on 2021/2/7.
//

import Foundation
import Alamofire


protocol CostcoRequestV2 {
    associatedtype Response: Codable
    var method: HTTPMethod { get }
    var apiManager: APIManager { get }
    var contentType: ContentType { get }
    var parametersEncoding: ParameterEncoding? { get }
    var decisions: [Decision] { get }
}


struct BaseRequestV2: CostcoRequestV2 {
    typealias Response = BaseResponse
    
    var method: HTTPMethod
    
    var apiManager: APIManager
    
    var contentType: ContentType
    
    var parametersEncoding: ParameterEncoding?
    
    var decisions: [Decision]

    
}

struct BaseResponse: Codable {
    
}


extension CostcoRequestV2 {
    
    func buildRequest(domin: String, memberId: String, guid: String, authToken: String)-> DataRequest {
        let endpoint: String = apiManager.endPoint(memberId: memberId, guid: guid, authToken: authToken)
        let headers: HTTPHeaders? = apiManager.headers(memberId: memberId, guid: guid, authToken: authToken)
        let parameters: Parameters? = apiManager.parameters(memberId: memberId, guid: guid, authToken: authToken)
        
        let urlString = domin + endpoint
        
        return contentType.buildRequest(urlString, method: method, parameters: parameters, encoding: parametersEncoding ?? JSONEncoding.default, headers: headers)
    }
}



enum DecisionAction<T: Codable> {
    case continueWith(Data, HTTPURLResponse)
    case restartWith([Decision])
    case errored(CostcoError)
    case done(T)
}


protocol Decision {
    func shouldApply<req: CostcoRequestV2>(reuqest: req, data: Data, response: HTTPURLResponse)-> Bool
    func apply<req: CostcoRequestV2>(reuqest: req, data: Data, response: HTTPURLResponse, closure: @escaping (DecisionAction<req.Response>)-> Void)
}
