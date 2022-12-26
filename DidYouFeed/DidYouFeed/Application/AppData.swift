//
//  AppData.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/26.
//

struct AppData {
    
    @UserDefault(key: UserDefaultsKey.userData, defaultValue: User())
    var userData: User
}
