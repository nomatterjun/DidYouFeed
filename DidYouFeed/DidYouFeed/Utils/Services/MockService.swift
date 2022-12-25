//
//  MockService.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/09.
//

import Foundation

import RxSwift

struct MockService {
    
    // MARK: - Singleton
    
    static let standard = MockService()
    
    // MARK: - Initializer
    
    private init() {
        
    }
    
    func getTaskMock() -> Observable<[Task]> {
        return .just((1...9).map {
            Task(
                title: "title\($0)",
                isDone: false
            )
        })
    }
    
    func getPetMock() -> [Pet] {
        (1...3).map {
            Pet(
                name: "초롬\($0)"
            )
        }
    }
    
    func getSpeciesMock() -> [String] {
        Species.allCases.map { $0.emoji }
    }
}
