//
//  TaskListCollectionView.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/08.
//

import UIKit

import ReactorKit
import SnapKit

final class TaskListCollectionView: UICollectionView {
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    convenience init(collectionViewLayout layout: UICollectionViewLayout) {
        self.init(frame: .zero, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
