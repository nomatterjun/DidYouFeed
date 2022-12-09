//
//  TaskMock.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/09.
//

import Foundation

func getTaskMock() -> [Task] {
    (1...3).map {
        Task(title: "title\($0)")
    }
}
