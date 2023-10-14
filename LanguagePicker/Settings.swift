//
//  Settings.swift
//  LanguagePicker
//
//  Created by Admin on 14.10.23.
//

import Foundation

final class Settings {
    
    static var sellectedLanguage: String? {
        get {
            return UserDefaults.standard.string(forKey: "lang")
        }
        set {
            let defaults = UserDefaults.standard
            let key = "lang"
            if let language = newValue {
                defaults.set(language, forKey: key)
            }
            else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}
