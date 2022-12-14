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

typealias TaskListSectionModel = SectionModel<Int, TaskListCellReactor>

final class HomeViewReactor: Reactor {
    
    // MARK: - Properties
    
    weak var coordinator: HomeCoordinator?
    var initialState: State
    
    enum Action {
        case viewDidLoad
        case buttonTap
        case toggleTaskDone(IndexPath)
    }
    
    enum Mutation {
        case updateDataSource([TaskListSectionModel])
        case buttonTap
    }
    
    struct State {
        var taskSections: [TaskListSectionModel]
    }
    
    // MARK: - Initializer
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        self.initialState = State(
            taskSections: [TaskListSectionModel(model: Int(), items: [])]
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
                    let section = TaskListSectionModel(model: Int(), items: sectionReactors)
                    return .updateDataSource([section])
                }
            
        case .buttonTap:
            return .just(.buttonTap)
            
        case let .toggleTaskDone(indexPath):
            guard let task = self.currentState.taskSections.first?.items[indexPath.item].currentState else {
                return Observable.empty()
            }
            switch task.isDone {
            case true:
                print("Task is done.")
            case false:
                print("Task is not done.")
            }
            return Observable.empty()
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
