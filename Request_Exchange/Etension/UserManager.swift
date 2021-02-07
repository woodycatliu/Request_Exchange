//
//  UserManager.swift
//  IOS_Costco
//
//  Created by cm0637 on 2020/10/13.
//  Copyright © 2020 CMoney. All rights reserved.
//

import Foundation

class UserManager {
    
    static let shared = UserManager()
   
    /// 會員名稱
    var memberName: String {
        
        return ""
    }
    
    /// 會員頭像
    var avatarUrl: String {
        return ""
    }
    
    /// 收藏商品數量
    var collectionCount: Int {
        return 0
    }
    
    /// 貢獻圖片數量
    var contributedImageCount: Int {
        return 0
    }
    
    /// 貢獻圖片列表
//    var contributedProductImages: [MemberImageData] {
//        return []
//    }
    
    /// 上傳發票數量
    var uploadedInvoiceCount: Int {
        return 0
    }
    
    /// 發文數量
    var postCount: Int {
        return 0
    }
    
    /// 獲得徽章數量
    var receivedRewardCount: Int {
        return 0
    }
    
    /// 文章按讚列表
    var articleLikeList: [Int] {
        return []
    }
    
    /// 留言按讚列表
    var commentLikeList: [Int] {
        return []
    }
    
    /// 徽章列表
    var rewardList: [RewardData] {
        return []
    }
    
    /// 商品收藏列表
//    var collectionProducts: [MemberCollectData] {
//        return []
//    }
    
    
    /// 文章列表
//    var articleList: [ArticleData] {
//        return []
//    }
    
    /// 登入模組會員id
    var memberId: Int {
        return 0
    }
    
    /// 登入模組會員帳號
    var memberAccount: String {
        return ""
    }
    
    /// 發票載具
    var invoiceCarrier: String {
        return ""
    }

    /// 登入模組guid
    var guid: String {
        return ""
    }
    
    /// 檢舉文章列表
    var blockArticleList: [Int] {
        return []
    }
    
    /// 檢舉使用者列表
    var blockUserList: [Int] {
        return []
    }
    
    /// 檢舉回覆列表
    var blockCommentList: [Int] {
        return []
    }
    
    /// 明星作家
    var isContributingWriter: Bool {
        return false
    }
    
    /// 聖誕節活動 分享數
    var shareCount = 0
    /// 聖誕節活動 按讚數
    var likeCount = 0
    
}
