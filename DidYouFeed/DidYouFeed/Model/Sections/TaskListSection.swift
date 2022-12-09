//
//  TaskListSection.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/08.
//

import RxDataSources

struct TaskListSection {
    typealias TaskSectionModel = SectionModel<TaskSection, TaskItem>
    
    enum TaskSection: Equatable {
        case section
    }
    
    enum TaskItem {
        case sectionItem(Task)
    }
}
