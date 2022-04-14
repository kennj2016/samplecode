//
//  PListManager.swift
//  SampleCode
//
//  Created by  KenNguyen on 07/06/2021.
//

import Foundation

class PListManager {
    
    static let shared = PListManager()

    private init() {}
    
    private static let languageViFileName = "Vietnamese"
    
    func readPropertyList(withName name: String = languageViFileName) -> [String: Any]? {
        // Format of the Property List
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
        // The path of the data
        guard let plistPath = Bundle.main.path(forResource: name, ofType: "plist") else { return nil }
        guard let plistXML = FileManager.default.contents(atPath: plistPath) else { return nil }
        do {
            // Convert the data to a dictionary and handle errors.
            guard let plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as? [String: Any] else { return nil }
            return plistData
            
        } catch {
            print("Error reading plist: \(error), format: \(propertyListFormat)")
        }
        return nil
    }
    
}
