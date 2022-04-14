//
//  AppConfiguration.swift
//  SampleCode
//
//  Created by  KenNguyen on 25.02.19.
//

import Foundation
import KeychainSwift

class AppConfiguration {
    
    lazy var apiBaseURL: String = {
        return ""
    }()
    
    lazy var SITE_KEY: String = {
        return ""
    }()
    
    lazy var SECRET_KEY: String = {
        return ""
    }()
    
    lazy var termOfServiceURL: String = {
        return ""
    }()
    lazy var policyURL: String = {
        return ""
    }()
    
    static func autoLogin() -> Bool {
        return getToken() != ""
    }
    
    static func getToken() -> String {
        return KeychainSwift().get(KeychainKeys.token.rawValue) ?? ""
    }
    static func setToken(join: String) {
        KeychainSwift().set(join, forKey: KeychainKeys.token.rawValue)
    }
    
    static func getExpires() -> String {
        return KeychainSwift().get(KeychainKeys.expires.rawValue) ?? ""
    }
    static func setgetExpires(join: String) {
        KeychainSwift().set(join, forKey: KeychainKeys.expires.rawValue)
    }
    
    static func logout() {
        KeychainSwift().delete(KeychainKeys.token.rawValue)
        KeychainSwift().delete(KeychainKeys.expires.rawValue)

    }
    
    static func resetData() {
        for key in KeychainKeys.allCases {
            KeychainSwift().delete(key.rawValue)
        }
    }
}
private enum KeychainKeys: String, CaseIterable {
    case token = "token"
    case expires = "expires"
}
