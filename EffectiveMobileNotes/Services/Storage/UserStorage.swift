//
//  UserDefaults.swift
//  EffectiveMobileNotes
//
//  Created by Вадим Мартыненко on 29.01.2025.
//

import Foundation

enum UserStorageKey: String {
    case isDataWasLoaded
}

final class UserStorage {
    static let shared = UserStorage()
    private init() {}
    
    var isDataWasLoaded: Bool {
        get {
            bool(for: .isDataWasLoaded)
        } set {
            save(newValue, for: .isDataWasLoaded)
        }
    }
}

private extension UserStorage {
    func save(_ value: Any, for key: UserStorageKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func bool(for key: UserStorageKey) -> Bool {
        UserDefaults.standard.bool(forKey: key.rawValue)
    }
}
