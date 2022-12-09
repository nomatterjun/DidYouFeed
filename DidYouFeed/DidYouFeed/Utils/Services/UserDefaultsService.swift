//
//  UserDefaultsService.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/09.
//

import Foundation

final class UserDefaultsService {
    
    // MARK: - Singleton
    
    static let standard = UserDefaultsService()
    
    // MARK: - Properties
    
    private var defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    // MARK: - Initializer
    
    private init() { }
    
    // MARK: - Functions
    
    func value<T>(forKey key: String) -> T? {
        return self.defaults.value(forKey: key) as? T
    }
    
    func set<T>(value: T?, forKey key: String) {
        self.defaults.set(value, forKey: key)
        self.defaults.synchronize()
    }
}
