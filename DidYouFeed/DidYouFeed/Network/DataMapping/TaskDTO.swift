//
//  TaskDTO.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/10.
//

import Foundation

struct TaskDTO: Codable {
    private let title: String
    private let isDone: Bool
    private let onTime: String
    
    init() {
        self.title = ""
        self.isDone = false
        self.onTime = Date().formatted(date: .omitted, time: .shortened)
    }
}
