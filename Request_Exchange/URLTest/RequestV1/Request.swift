//
//  Request.swift
//  Request_Exchange
//
//  Created by Woody Liu on 2021/2/6.
//

import Foundation
import Alamofire


struct BaseRequest: CostcoRequest {
    
    var endPointAdapter: EndPointAdapter
    
    var method: HTTPMethod
    
    var headersAdapter: HeadersAdapter?
    
    var parametersAdapter: ParametersAdapter?
    
    var parametersEncoding: ParameterEncoding?
    
    var contentType: ContentType

}

protocol CostcoRequest{
    var endPointAdapter: EndPointAdapter { get }
    var method: HTTPMethod { get }
    var headersAdapter: HeadersAdapter? { get }
    var parametersAdapter: ParametersAdapter? { get }
    var parametersEncoding: ParameterEncoding? { get }
    var contentType: ContentType { get }
    
}
extension CostcoRequest {
    func buildRequest(domin: String, memberId: String, guid: String, authToken: String)-> DataRequest {
        let endpoint: String = endPointAdapter.adapter(memberId: memberId, guid: guid, authToken: authToken)
        let headers: HTTPHeaders? = headersAdapter?.adapter(memberId: memberId, guid: guid, authToken: authToken)
        let parameters: Parameters? = parametersAdapter?.adapter(memberId: memberId, guid: guid, authToken: authToken)
        
        let urlString = domin + endpoint

        
        return contentType.buildRequest(urlString, method: method, parameters: parameters, encoding: parametersEncoding ?? JSONEncoding.default, headers: headers)
    }
}


enum EndPointAdapter: AlamofireAdapter{
    typealias AlamofireUseable = String
    case deleteArticleLike
    func adapter(memberId: String, guid: String, authToken: String) -> String {
        switch self {
        case .deleteArticleLike:
            return "/api/v1/member/\(memberId)/liked/post"
        }
    }
}

enum HeadersAdapter: AlamofireAdapter {
    typealias AlamofireUseable = HTTPHeaders?
    
    case deleteArticleLike
    
    func adapter(memberId: String, guid: String, authToken: String) -> HTTPHeaders? {
        switch self {
        case .deleteArticleLike:
            return [
                "memberId": memberId,
                "guid": guid,
                "authToken": authToken
            ]
        }
    }
    
}


enum ParametersAdapter: AlamofireAdapter {
    typealias AlamofireUseable = Parameters?
    
    case deleteArticleLike(articleId: String)
    
    func adapter(memberId: String, guid: String, authToken: String) -> Parameters? {
        switch self {
        
        case .deleteArticleLike(let articleId):
            return [
                "id": articleId
            ]
        }
    }
}



protocol AlamofireAdapter {
    associatedtype AlamofireUseable
    func adapter(memberId: String, guid: String, authToken: String) -> AlamofireUseable
}


