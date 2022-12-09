//
//  MockService.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/09.
//

import Foundation

struct MockService {
    
    // MARK: - Singleton
    
    static let standard = MockService()
    
    // MARK: - Initializer
    
    private init() {
        
    }
    
    func getTaskMock() -> [Task] {
        (1...3).map {
            Task(title: "title\($0)")
        }
    }
}
