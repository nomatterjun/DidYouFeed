//
//  ModalViewController.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/06.
//

import UIKit

import ReactorKit
import RxSwift

final class ModalViewController: UIViewController, View {
    
    typealias Reactor = ModalViewModel
    
    var disposeBag = DisposeBag()
    
    func bind(reactor: ModalViewModel) {
        //
    }
}
