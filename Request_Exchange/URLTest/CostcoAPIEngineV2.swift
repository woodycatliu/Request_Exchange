//
//  CostcoAPI.swift
//  Request_Exchange
//
//  Created by Woody Liu on 2021/2/7.
//

import Foundation

class CostcoApiEngineV2 {
    static let shared = CostcoApiEngineV2()
    
    private var domainV2: String {
        return "CostcoApiBaseV2.domain"
    }
    
    private var memberId: String {
        return ""
    }
    
    private var guid: String {
        return ""
    }
    
    private var authToken: String {
        return ""
    }

//    private var domainV2: String {
//        return CostcoApiBaseV2.domain
//    }
//
//    private var memberId: String {
//        return "\(LoginModel.memberProfileCache.memberPk)"
//    }
//
//    private var guid: String {
//        return LoginModel.memberProfileCache.guid
//    }
//
//    private var authToken: String {
//        return LoginModel.memberProfileCache.authToken
//    }
    
    
    func send<req: CostcoRequestV2>(_ request: req, decisions: [Decision]? = nil, completion: @escaping (Result<req.Response, CostcoError>) -> Void) {
        
        let dataRequest = request.buildRequest(domin: domainV2, memberId: memberId, guid: guid, authToken: authToken)
        dataRequest.response { dataResponse in
            
            if let error = dataResponse.error {
                Logger.log(message: "Error :\(error)")
                completion(.failure(.failure))
                return
            }
            
            guard let data = dataResponse.data else {
                completion(.failure(.failure))
                return
            }
            
            guard let response = dataResponse.response else {
                completion(.failure(.failure))
                return
            }
            
            self.handleDecision(request, data: data, response: response, decisions: request.decisions, completion: completion)
            
            
            switch dataResponse.result {
            case .success(let data):
                guard let data = data, let jsonData = try? JSONDecoder().decode(req.Response.self, from: data) else { return }
                completion(.success(jsonData))
            case .failure(let error):
                Logger.log(message: "Error :\(error)")
                completion(.failure(.failure))
            }
        }
        
    }
    
    
    func handleDecision<req: CostcoRequestV2>(_ request: req, data: Data, response: HTTPURLResponse, decisions: [Decision], completion: @escaping (Result<req.Response, CostcoError>) -> Void) {
        
        guard !decisions.isEmpty else {
            completion(.failure(.failure))
            return }
        
        var decisions = decisions
        let current = decisions.removeFirst()
        
        guard current.shouldApply(reuqest: request, data: data, response: response) else {
            handleDecision(request, data: data, response: response, decisions: decisions, completion: completion)
            return
        }
        
        
        current.apply(reuqest: request, data: data, response: response) {
            action in
            
            switch action {
            
            case .continueWith(let data, let response):
                self.handleDecision(request, data: data, response: response, decisions: decisions, completion: completion)
            case .restartWith(let decisions):
                self.send(request, decisions: decisions, completion: completion)
            case .errored(let error):
                completion(.failure(error))
            case .done(let value):
                completion(.success(value))
            }
            
        }
        
        
        
    }
    
    
}

