//
//  Decision.swift
//  Request_Exchange
//
//  Created by Woody Liu on 2021/2/8.
//

import Foundation

enum DecisionAction<T: Codable> {
    case continueWith(Data, HTTPURLResponse)
    case restartWith([Decision])
    case errored(CostcoError)
    case done(T)
}


protocol Decision {
    
    func shouldApply<req: CostcoRequestV2>(reuqest: req, data: Data, response: HTTPURLResponse)-> Bool
    func apply<req: CostcoRequestV2>(reuqest: req, data: Data, response: HTTPURLResponse, closure: @escaping (DecisionAction<req.Response>)-> Void)
    
    func shouldApply<T: Codable, req: CostcoRequestV3>(_ request: req, codable: T, data: Data, response: HTTPURLResponse)-> Bool
    func apply<T: Codable, req: CostcoRequestV3>(_ request: req, codable: T, data: Data, response: HTTPURLResponse, closure: @escaping (DecisionAction<T>)-> Void)
}


