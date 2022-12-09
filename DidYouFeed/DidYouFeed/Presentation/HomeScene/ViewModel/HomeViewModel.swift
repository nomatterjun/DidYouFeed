//
//  HomeViewReactor.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/05.
//

import Foundation

import ReactorKit
import RxDataSources
import RxSwift

final class HomeViewModel: Reactor {
    
    // MARK: - Properties
    
    weak var coordinator: HomeCoordinator?
    var initialState = State()
    
    enum Action {
        case viewDidLoad
        case buttonTap
    }
    
    enum Mutation {
        case updateDataSource
        case buttonTap
    }
    
    struct State {
        var taskSection = TaskListSection.TaskSectionModel(
            model: .section,
            items: []
        )
    }
    
    // MARK: - Initializer
    
    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }
    
    // MARK: - Functions
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .viewDidLoad:
            return Observable<Mutation>.just(.updateDataSource)
        case .buttonTap:
            return .just(.buttonTap)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .updateDataSource:
            let tasks = getTaskMock()
            let items = tasks.map(TaskListSection.TaskItem.sectionItem)
            let sectionModel = TaskListSection.TaskSectionModel(model: .section, items: items)
            state.taskSection = sectionModel
        case .buttonTap:
            print("Tapped")
            return state
        }
        return state
    }
    
}
