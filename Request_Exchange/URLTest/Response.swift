//
//  Response.swift
//  Request_Exchange
//
//  Created by Woody Liu on 2021/2/6.
//

import Foundation


struct CostcoResponse<T: Codable> {
    let data: T?
    let response: HTTPURLResponse?
    let error: Error?
}



