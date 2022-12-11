//
//  LoginViewController.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/11.
//

import UIKit

import ReactorKit
import RxSwift
import SnapKit
import Then

final class LoginViewController: BaseViewController, View {
    typealias Reactor = LoginReactor
    
    // MARK: - Properties
    
    // MARK: - UI Components
    
    // MARK: - Initializer
    
    init(reactor: LoginReactor) {
        super.init()
        self.reactor = reactor
    }
    
    required convenience init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureLayout()
        self.configureStyles()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        self.configureConstraints()
    }
    
    // MARK: - Binding
    
    func bind(reactor: LoginReactor) {
        //
    }
    
    // MARK: - Functions
    
    
}

// MARK: - UI Configuration
private extension LoginViewController {
    
    func configureLayout() {
        
    }
    
    func configureConstraints() {
        
    }
    
    func configureStyles() {
        self.view.backgroundColor = .magenta
    }
    
}

