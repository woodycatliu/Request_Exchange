//
//  ContentType.swift
//  Request_Exchange
//
//  Created by Woody Liu on 2021/2/7.
//

import Foundation
import Alamofire

enum ContentType {
    case urlencoded
    case multipartFormData
    
    func buildRequest(_ convertible: URLConvertible, method: HTTPMethod, parameters: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?)-> DataRequest{
    
        switch self {
        case .urlencoded:
            return AF.request(convertible, method: method, parameters: parameters, encoding: encoding, headers: headers)
        case .multipartFormData:
            
            return AF.upload(multipartFormData: {
                multipartFormData in
                for (key, value) in parameters! {

                    guard let data = (value as? String)?.data(using: .utf8) else {break}
                    multipartFormData.append(data, withName: key)
                }
                
            }, to: convertible, method: method, headers: headers)
        }
    }
}
