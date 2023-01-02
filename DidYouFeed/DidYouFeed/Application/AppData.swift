//
//  AppData.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/26.
//

struct AppData {
	
	@UserDefault(key: UserDefaultsKey.isLoggedIn, defaultValue: false)
	static var isLoggedIn: Bool
    
    @UserDefault(key: UserDefaultsKey.userData, defaultValue: User())
    static var userData: User
    
    @UserDefault(key: UserDefaultsKey.familyData, defaultValue: Family())
    static var familyData: Family
    
    @UserDefault(key: UserDefaultsKey.petsData, defaultValue: [])
    static var petsData: [Pet]
}
