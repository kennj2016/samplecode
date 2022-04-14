//
//  LanguageManager.swift
//  SampleCode
//
//  Created by  KenNguyen on 08/06/2021.
//

enum LanguageType: String {
    case vi
    case en
}

class LanguageManager {
    
    static let shared = LanguageManager()

    private init() {}
    
    var currentLanguage: LanguageType = .vi
    
}
