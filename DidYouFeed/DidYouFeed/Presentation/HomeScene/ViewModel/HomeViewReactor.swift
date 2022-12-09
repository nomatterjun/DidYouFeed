//
//  HomeViewReactor.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/05.
//

import UIKit

import ReactorKit
import RxDataSources
import RxSwift

typealias TaskListSection = SectionModel<Int, TaskListCellReactor>

final class HomeViewReactor: Reactor {
    
    // MARK: - Properties
    
    weak var coordinator: HomeCoordinator?
    var initialState: State
    
    enum Action {
        case viewDidLoad
        case buttonTap
    }
    
    enum Mutation {
        case updateDataSource([TaskListSection])
        case buttonTap
    }
    
    struct State {
        var taskSections: [TaskListSection]
    }
    
    // MARK: - Initializer
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        self.initialState = State(
            taskSections: [TaskListSection(model: Int(), items: [])]
        )
    }
    
    // MARK: - Functions
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return MockService.standard.getTaskMock() // - TODO: 실제 데이터 fetch 필요
                .map { tasks in
                    let sectionReactors = tasks.map { task in
                        TaskListCellReactor(task: task)
                    }
                    let section = TaskListSection(model: Int(), items: sectionReactors)
                    return .updateDataSource([section])
                }
            
        case .buttonTap:
            return .just(.buttonTap)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case let .updateDataSource(sections):
            state.taskSections = sections
        case .buttonTap:
            print("Tapped")
            return state
        }
        return state
    }
    
}
