//
//  UserDefaultsExtensions.swift
//  SwiftBackend
//
//  Created by cm0522 on 2019/4/11.
//  Copyright © 2019 CMoney. All rights reserved.
//

import Foundation

/// UserDefaults的key
public class DefaultsKeys {}

/// UserDefaults的key
public class DefaultsKey<ValueType>: DefaultsKeys {
    
    public let key: String
    
    public init(_ key: String) {
        self.key = key
    }
}

// MARK: - 自定義UserDefaults的key
extension DefaultsKeys {
    
    /// [登入和推播模組通用] 推播token
    public static let pushToken = DefaultsKey<String>("pushToken")
    
    /// [登入和推播模組通用] 推播token(FCM)
    public static let pushTokenForFCM = DefaultsKey<String>("pushTokenForFCM")
    
    /// 是否螢幕恆亮
    public static let isIdleTimerDisabled = DefaultsKey<Bool>("isIdleTimerDisabled")
    
    /// 所有使用者的搜尋歷史紀錄(ex.[Guid : [["Key": "0050", "Name": "元大台灣50"], ["Key": "0051", "Name": "元大中型100"]]])
    public static let allUserSearchHistory = DefaultsKey<[String: [[String: String]]]>("allUserSearchHistory")
    
    /// 熱門股票(ex.[["Key": "0050", "Name": "元大台灣50"], ["Key": "0051", "Name": "元大中型100"]])
    public static let popularStocks = DefaultsKey<[[String: String]]>("popularStocks")
    
    /// 熱門股票過期時間戳
    public static let popularStocksExpirationTimeStamp = DefaultsKey<Int>("popularStocksExpirationTimeStamp")
}

// MARK: - 搭配自定義key的UserDefaults擴充方法
extension UserDefaults {
    
    public func remove<T>(_ key: DefaultsKey<T>) {
        removeObject(forKey: key.key)
    }
    
    public subscript(key: DefaultsKey<Bool>) -> Bool {
        get { return bool(forKey: key.key) }
        set { set(newValue, forKey: key.key) }
    }
    
    public subscript(key: DefaultsKey<String>) -> String {
        get { return string(forKey: key.key) ?? "" }
        set { set(newValue, forKey: key.key) }
    }
    
    public subscript(key: DefaultsKey<Int>) -> Int {
        get { return integer(forKey: key.key) }
        set { set(newValue, forKey: key.key) }
    }
    
    public subscript(key: DefaultsKey<UInt>) -> UInt? {
        get { return object(forKey: key.key) as? UInt}
        set { set(newValue, forKey: key.key) }
    }
    
    public subscript(key: DefaultsKey<Date>) -> Date? {
        get { return object(forKey: key.key) as? Date}
        set { set(newValue, forKey: key.key) }
    }
    
    public subscript<T>(key: DefaultsKey<T>) -> T? {
        get {
            if let data = data(forKey: key.key) {
                return NSKeyedUnarchiver.unarchiveObject(with: data) as? T
            }
            return nil
        }
        set {
            if let newValue = newValue {
                set(NSKeyedArchiver.archivedData(withRootObject: newValue), forKey: key.key)
            }
        }
    }
}
