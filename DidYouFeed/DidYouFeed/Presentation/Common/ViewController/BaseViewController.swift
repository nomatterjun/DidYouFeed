//
//  BaseViewController.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/05.
//

import UIKit

import RxSwift

class BaseViewController: UIViewController {
    
    // MARK: - Rx
    
    var disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init()
    }
    
    // MARK: - Layout Constraints
    
    private(set) var didSetupConstraints = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.setupLayouts()
            self.setupConstraints()
            self.setupStyles()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    func setupLayouts() {
        // override
    }
    
    func setupConstraints() {
        // override
    }
    
    func setupStyles() {
        self.view.backgroundColor = BrandColor.dfWhite
        // override
    }
}
