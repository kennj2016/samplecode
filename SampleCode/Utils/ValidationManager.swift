//
//  ValidationManager.swift
//  SampleCode
//
//  Created by  KenNguyen on 29/09/2021.
//

import PhoneNumberKit

class ValidationManager {
    static let shared = ValidationManager()
    
    private init() {}
    
    private let phoneNumberKit = PhoneNumberKit()
    
    func isValidPhoneNumber(phone: String?) -> Bool {
        guard let phone = phone, !phone.isEmpty else { return false }
        return phoneNumberKit.isValidPhoneNumber(phone,withRegion: "VN")
    }
    
    func isValidUserName(username: String?) -> Bool {
        guard let username = username, !username.isEmpty else { return false }
        return username.count > 0
    }
    
    func isValidPassword(pass: String?) -> Bool {
        guard let pass = pass, !pass.isEmpty else { return false }
        return pass.count > 5
    }
    
    func isValidEmail(email: String?) -> Bool {
        guard let email = email, !email.isEmpty else { return false }
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}", options: .caseInsensitive)
            return regex.firstMatch(in: email, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, email.count)) != nil
        } catch {
            return false
        }
    }
}
