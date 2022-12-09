//
//  TaskListCellViewModel.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/08.
//

import ReactorKit

final class TaskListCellViewModel: Reactor {
    typealias Action = NoAction
    
    var initialState: Task
    
    init(task: Task) {
        self.initialState = task
    }
}
