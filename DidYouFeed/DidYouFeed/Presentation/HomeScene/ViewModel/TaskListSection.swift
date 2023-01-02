//
//  TaskListSection.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/30.
//

import RxDataSources

struct TaskListSection {
	typealias TaskListModel = SectionModel<Int, TaskListItem>
	
	enum TaskListItem: Equatable {
		case base
	}
}
