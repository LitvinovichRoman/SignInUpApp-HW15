//
//  UserDefaultsExtension.swift
//  SignInUpApp-HW15
//
//  Created by Роман Литвинович on 29.08.23.
//

import Foundation

extension UserDefaults {
    enum Keys: String, CaseIterable {
        case email
        case name
        case password
    }
    
    func reset() {
        let allCases = Keys.allCases
        allCases.forEach {
            removeObject(forKey: $0.rawValue)
        }
    }
}
