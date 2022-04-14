//
//  SampleCodeLocalDataManager.swift
//  SampleCode
//
//  Created by  KenNguyen on 02/10/2021.
//

import Foundation

struct Token {
    
    fileprivate let userDefaults: UserDefaults
    
    var email: String? {
        get {
            return userDefaults.string(forKey: UserDefaultKey.kEmail.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultKey.kEmail.rawValue)
            userDefaults.synchronize()
        }
    }
    
    var password: String? {
        get {
            return userDefaults.string(forKey: UserDefaultKey.kPassWord.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultKey.kPassWord.rawValue)
            userDefaults.synchronize()
        }
    }
    
    var token: String? {
        get {
            return userDefaults.string(forKey: UserDefaultKey.kUserInToken.rawValue) ?? ""
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaultKey.kUserInToken.rawValue)
            userDefaults.synchronize()
        }
    }
    
    
    var tokenExists: Bool {
        
        guard let token = self.token, token.count > 0 else {
            return false
        }
        return true
    }
    
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    init() {
        self.userDefaults = UserDefaults.standard
    }
    
    func clear() {
        for key in UserDefaultKey.allCases {
            userDefaults.removeObject(forKey: key.rawValue)
            userDefaults.synchronize()
        }
        
    }
}

//MARK:- ENUM
enum UserDefaultKey: String, CaseIterable {
    case kEmail = "didEmailUser"
    case kUserInToken = "kUserInToken"
    case kPassWord = "kPassWord"
    
}
