//
//  ModalViewController.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/06.
//

import UIKit

import RxSwift

class ModalViewController: BaseViewController {
    
    // MARK: - Constants
    
    private enum Metric {
        static let modalViewCornerRadius = 48.0
    }
    
    // MARK: - Properties
    
    var modalType: ModalType
    
    // MARK: - Initializer
    
    init(modalType: ModalType) {
        self.modalType = modalType
        super.init()
    }
    
    required convenience init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func setupStyles() {
        super.setupStyles()
        
        if let sheetPresentationController {
            sheetPresentationController.preferredCornerRadius = Metric.modalViewCornerRadius
            switch self.modalType {
            case .half:
                sheetPresentationController.detents = [.medium()]
            case .full:
                sheetPresentationController.detents = [.large()]
            }
        }
    }
}
