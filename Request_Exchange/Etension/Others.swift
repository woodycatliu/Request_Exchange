//
//  Others.swift
//  Request_Exchange
//
//  Created by Woody Liu on 2021/2/7.
//

import Foundation

struct RewardData: Codable {
    let type: RewardType
    let name: String
    var level: Int
    var description: String
}

enum RewardType: Int, Codable {
    /// 登入
    case login = 0
    /// 攝影
    case contributeProductImage
    /// 話題
    case post
    /// 聽眾
    case comment
    /// 消費
    case uploadInvoice
    
    /// 換成 ui 所需順序
    func convertToUI() -> Int {
        switch self {
        case .login:
            return 4
        case .contributeProductImage:
            return 0
        case .post:
            return 1
        case .comment:
            return 2
        case .uploadInvoice:
            return 3
        }
    }
}



enum CostcoError: Error {
    case success
    case failure
    case verifyExpired
    case exist
    case unknown
    case decode
    case alreadyUpload
    
//    func getErrorMessage() -> ErrorMessage {
//        switch self {
//        case .success:
//            return ErrorMessage(title: NSLocalizedString("成功", comment: ""), message: NSLocalizedString("成功", comment: ""))
//        case .failure:
//            return ErrorMessage(title: NSLocalizedString("發生系統錯誤！", comment: ""), message: NSLocalizedString("請稍後再試～", comment: ""))
//        case .verifyExpired:
//            return ErrorMessage(title: NSLocalizedString("你上一次的帳號登入失效囉！", comment: ""), message: NSLocalizedString("請重新登入會員", comment: ""))
//        case .exist:
//            return ErrorMessage(title: NSLocalizedString("哎呀！已有人上傳圖片🥺", comment: ""), message: NSLocalizedString("已有特派員早一步上傳圖片了", comment: ""))
//        case .unknown:
//            return ErrorMessage(title: NSLocalizedString("發生未知錯誤！", comment: ""), message: NSLocalizedString("請稍後再試～", comment: ""))
//        case .decode:
//            return ErrorMessage(title: NSLocalizedString("發生資料錯誤！", comment: ""), message: NSLocalizedString("請稍後再試～", comment: ""))
//        case .alreadyUpload:
//            return ErrorMessage(title: NSLocalizedString("這張發票已上傳過囉！", comment: ""), message: NSLocalizedString("請再試試看～", comment: ""))
//        }
//    }
}


class Logger {
    
    private init() {
    }
    
    static func log<T>(message: T, file: String = #file, method: String = #function) {
        #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        NSLog("[\(fileName): \(method)] \(message)")
        #endif
    }
    
    static func log<T, U>(message: T, caller: U, method: String = #function) {
        #if DEBUG
        NSLog("[\(caller).\(method)] \(message)")
        #endif
    }
}
