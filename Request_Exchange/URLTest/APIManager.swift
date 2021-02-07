//
//  RequestV2_APIManager.swift
//  Request_Exchange
//
//  Created by Woody Liu on 2021/2/7.
//

import Foundation
import Alamofire

protocol APIAdapter {
    associatedtype AlamofireEndPoint
    associatedtype AlamofireParameters
    associatedtype AlamofireHeaders
    
    func endPoint(memberId: String, guid: String, authToken: String)-> AlamofireEndPoint
    func headers(memberId: String, guid: String, authToken: String)-> AlamofireHeaders?
    func parameters(memberId: String, guid: String, authToken: String)-> AlamofireParameters?
}


enum APIManager: APIAdapter {
    
    typealias AlamofireEndPoint = String
    typealias AlamofireParameters = Parameters
    typealias AlamofireHeaders = HTTPHeaders
    
    /// 按留言讚
    case addCommentLike(id: Int)
    /// 留言刪除讚
    case deleteCommentLike(id: Int)
    /// 刪除文章留言
    case deleteComment(id: Int)
    /// 取得會員資料
    case getMemberDetail
    /// 更新會員名稱
    case updateMemberName(name: String)
    /// 獲得文章詳細資訊（沒有接留言）
    case getArticleDetail(postId: Int)
    /// 獲得文章留言一次拉全部
    case getCommentList(postId: Int, time: TimeInterval)
    /// 查看所有獎勵列表
    case getRewardList(memberId: Int)
    /// 拿到貢獻圖片列表
    case getContributedImageList(memberId: Int)
    /// 拿到會員發過的文章(只需要memberId)
    case getMemberArticleList(memberId: Int)
    /// 刪除文章
    case deleteArticle(postId: Int)
    /// 文章取消讚
    case deleteArticleLike(articleId: Int)
    /// 文章按讚
    case addArticleLike(articleId: Int)
    /// 查看已取得或未取得獎勵
    case getRewardCollection(isReceived: Bool = false)
    /// 取得已達成獎勵
    case recieveReward(reward: RewardData)
    /// 取得別人的會員資訊
    case getMemberProfile(memberId: Int)
    /// 發文時，圖片上傳(imgData multipartFormData)
    case articleImageUpload
    /// 發布文章
    case postArticle(productId: String, content: String, media: [String])
    /// 發布更改後的文章
    case postEditedArticle(postId: Int, productId: String, content: String, media: [String])
    /// 載具綁定會員
    case bindCarrier(code: String, cardEncrypt: String)
    /// 刪除載具綁定
    case deleteBindCarrier
    /// 紀錄點擊推播次數
    case uploadPushRecord(type: Int)
    /// 拿到商品詳細資料
    case getItemDetail(id: String)
    /// 收藏商品
    case addCollection(id: String)
    /// 刪除收藏商品
    case deleteCollection(id: String)
    /// 拿到文章列表(商品頁面底下)
    case getArticleList(productId: String, time: Int)
    /// 上傳商品圖片 (imgData multipartFormData)
    case uploadImage(productId: String)
    /// 重新上傳商品圖片 (imgData multipartFormData
    case reuploadImage(productId: String)
    /// 刪除上傳商品圖片 (imgData multipartFormData
    case deleteImage(productId: String)
    /// 拿到通知中心列表
    case getMemberNoticeList(time: Int)
    
//MARK: 節慶活動
    
    /// 上傳分享次數
    case uploadShareCount
    /// 拿到活動相關計數
    case getActivityLottery(start: Int, end: Int)
    
    func endPoint(memberId: String, guid: String, authToken: String) -> String {
        switch self {
        case .addCommentLike:
            return "/api/v1/member/\(memberId)/liked/comment"
        case .deleteCommentLike:
            return "/api/v1/member/\(memberId)/liked/comment"
        case .deleteComment:
            return "/api/v1/forum/comment"
        case .getMemberDetail:
            return "/api/v2.1/member/\(memberId)/profile"
        case .updateMemberName:
            return "/api/v1/member/\(memberId)/name"
        case .getArticleDetail(let postId):
            return "/api/v1/forum/posts/\(postId)"
        case .getCommentList(let postId, _):
            return "/api/v2/forum/posts/\(postId)/comments"
        case .getRewardList(let memberId):
            return "/api/v1/member/\(memberId)/rewards"
        case .getContributedImageList(let memberId):
            return "/api/v1/member/\(memberId)/contributed/images"
        case .getMemberArticleList:
            return "/api/v1/forum"
        case .deleteArticle:
            return "/api/v1/forum/post"
        case .deleteArticleLike:
            return "/api/v1/member/\(memberId)/liked/post"
        case .addArticleLike:
            return "/api/v1/member/\(memberId)/liked/post"
        case .getRewardCollection:
            return "/api/v1/member/\(memberId)/reward"
        case .recieveReward:
            return "/api/v1/member/\(memberId)/reward"
        case .getMemberProfile(let memberId):
            return "/api/v1.1/member/\(memberId)/profile"
        case .articleImageUpload:
            return "/api/v1/file/upload"
        case .postArticle:
            return "/api/v1/forum/post"
        case .postEditedArticle:
            return "/api/v1/forum/post"
        case .bindCarrier:
            return "/api/v1/member/\(memberId)/invoice/carrier"
        case .deleteBindCarrier:
            return "/api/v1/member/\(memberId)/invoice/carrier"
        case .uploadPushRecord:
            return "/api/v1/setting/message"
        case .getItemDetail(let id):
            return "/api/v1/product/\(id)"
        case .addCollection:
            return "/api/v1/member/\(memberId)/collection/products"
        case .deleteCollection:
            return "/api/v1/member/\(memberId)/collection/products"
        case .getArticleList:
            return "/api/v1/forum"
        case .uploadImage(let productId):
            return "/api/v1/product/\(productId)/image"
        case .reuploadImage(let productId):
            return "/api/v1/product/\(productId)/image"
        case .deleteImage(let productId):
            return "/api/v1/product/\(productId)/image"
        case .getMemberNoticeList:
            return "/api/v1/member/\(memberId)/notifications"
            
// MARK: 節慶活動 - endpoint
        case .uploadShareCount:
            return "/api/v1/event/\(memberId)/sharing"
        case .getActivityLottery:
            return "/api/v1/event/\(memberId)/sharing"
        }
    }
    
    func headers(memberId: String, guid: String, authToken: String) -> HTTPHeaders? {
        switch self {
        case .addCommentLike:
            return [
                "guid": guid,
                "authToken": authToken
            ]
            
        case .deleteCommentLike:
            return [
                "guid": guid,
                "authToken": authToken
            ]
            
        case .deleteComment:
            return [
                "guid": guid,
                "authToken": authToken
            ]
            
        case .getMemberDetail:
            return [
                "guid": guid,
                "authToken": authToken
            ]
            
        case .updateMemberName:
            return [
                "guid": guid,
                "authToken": authToken
            ]
            
        case .getArticleDetail:
            return nil
            
        case .getCommentList:
            return nil
            
        case .getRewardList:
            return [
                "guid": guid,
                "authToken": authToken
            ]
            
        case .getContributedImageList:
            return [
                "guid": guid,
                "authToken": authToken
            ]
            
            
        case .getMemberArticleList:
            return nil
            
        case .deleteArticle:
            return [
                "guid": guid,
                "authToken": authToken
            ]
            
        case .deleteArticleLike:
            return [
                "memberId": memberId,
                "guid": guid,
                "authToken": authToken
            ]
            
        case .addArticleLike:
            return [
                "memberId": memberId,
                "guid": guid,
                "authToken": authToken
            ]
            
        case .getRewardCollection:
            return [
                "guid": guid,
                "authToken": authToken
            ]
            
        case .recieveReward:
            return [
                "guid": guid,
                "authToken": authToken
            ]
            
        case .getMemberProfile:
            return nil
            
        case .articleImageUpload:
            return [
                "guid": guid,
                "authToken": authToken,
                "memberId": memberId
            ]
            
        case .postArticle:
            return [
                "guid": guid,
                "authToken": authToken
            ]
            
        case .postEditedArticle:
            return [
                "guid": guid,
                "authToken": authToken
            ]
            
        case .bindCarrier:
            return [
                "guid": guid,
                "authToken": authToken
            ]
            
        case.deleteBindCarrier:
            return [
                "guid": guid,
                "authToken": authToken
            ]
            
        case .uploadPushRecord:
            return [
                "guid": guid,
                "authToken": authToken
            ]
            
        case .getItemDetail:
            return nil
            
        case .addCollection:
            return [
                "guid": guid,
                "memberId": memberId,
                "authToken": authToken
            ]
            
        case .deleteCollection:
            return [
                "guid": guid,
                "memberId": memberId,
                "authToken": authToken
            ]
            
        case .getArticleList:
            return nil
            
        case .uploadImage:
            return [
                "guid": guid,
                "authToken": authToken,
                "memberId": memberId
            ]
            
        case .reuploadImage:
            return [
                "guid": guid,
                "authToken": authToken,
                "memberId": memberId
            ]
            
        case .deleteImage:
            return [
                "guid": guid,
                "authToken": authToken,
                "memberId": memberId
            ]
            
        case .getMemberNoticeList:
            return [
                "guid": guid,
                "authToken": authToken
            ]
           
// MARK: 節慶活動 - header
        
        case .uploadShareCount:
            return [
                "guid": guid,
                "authToken": authToken
            ]
            
        case .getActivityLottery:
            return [
                "guid": guid,
                "authToken": authToken
            ]
        }
        
    }
    
    func parameters(memberId: String, guid: String, authToken: String) -> Parameters? {
        switch self {
        case .addCommentLike(let id):
            return [
                "id": id
            ]
            
        case .deleteCommentLike(let id):
            return [
                "id": id
            ]
            
        case .deleteComment(let id):
            return [
                "memberId": "\(memberId)",
                "commentId": id
            ]
            
        case .getMemberDetail:
            return nil
            
        case .updateMemberName(let name):
            return [
                "name": name
            ]
            
        case .getArticleDetail:
            return nil
            
        case .getCommentList:
            return nil
            
        case .getRewardList:
            return nil
            
        case .getContributedImageList:
            return nil
            
        case .getMemberArticleList(let memberId):
            return [
                "memberId": memberId
            ]
            
        case .deleteArticle(let postId):
            return [
                "postId": postId,
                "memberId": memberId
            ]
            
        case .deleteArticleLike(let articleId):
            return [
                "id": articleId
            ]
            
        case .addArticleLike(let articleId):
            return [
                "id": articleId
            ]
            
        case .getRewardCollection(let isReceived):
            return [
                "isReceived": String(isReceived)
            ]
            
        case .recieveReward(let reward):
            return [
                "type": reward.type.rawValue,
                "level": reward.level
            ]
            
        case .getMemberProfile:
            return nil
            
        case .articleImageUpload:
            return nil
            
        case .postArticle(let productId, let content, let media):
            return  [
                "memberId": memberId,
                "productId": productId,
                "content": content,
                "media": media
            ]
            
        case .postEditedArticle(let postId, let productId, let content, let media):
            return [
                "memberId": memberId,
                "postId": postId,
                "productId": productId,
                "content": content,
                "media": media
            ]
            
        case .bindCarrier(let code, let cardEncrypt):
            return [
                "code": code,
                "cardEncrypt": cardEncrypt
            ]
            
        case .deleteBindCarrier:
            return nil
            
        case .uploadPushRecord(let type):
            return [
                "memberId": memberId,
                "type": type,
                "pushToken": UserDefaults.standard[.pushTokenForFCM]
            ]
            
        case .getItemDetail:
            return nil
            
        case .addCollection(let id):
            return [
                "id": id,
                "time": Date().timeIntervalSince1970
            ]
            
        case .deleteCollection(let id):
            return [
                "id": id,
                "time": Date().timeIntervalSince1970
            ]
            
        case .getArticleList(let productId, let time):
            return [
                "time": time,
                "productId": productId
            ]
            
        case .uploadImage:
            return [
                "identity": memberId,
                "name": UserManager.shared.memberName
            ]
            
        case .reuploadImage:
            return [
                "identity": memberId,
                "name": UserManager.shared.memberName
            ]
            
        case .deleteImage:
            return [
                "identity": memberId,
                "name": UserManager.shared.memberName
            ]
            
        case .getMemberNoticeList(let time):
            return [
                "before": time
            ]
            
// MARK: 節慶活動 - parameter
        
        case .uploadShareCount:
            return nil
            
            
        case .getActivityLottery(let start, let end):
            return [
                "start": start,
                "end": end
            ]
        }
    }
    
}





