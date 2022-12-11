//
//  RealtimeDatabaseService.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/10.
//

import Foundation

import Firebase
import RxRelay
import RxSwift

typealias FirebaseDictionary = [String: Any]
typealias FirebasePath = [String]

final class RealtimeDatabaseService {
    private let databaseReference = Database.database().reference()
    
    /// 배열 형태로 경로를 순서대로 받아 접근합니다.
    /// child().child().child()...와 같이 사용하지 않도록!
    private func childReference(of path: FirebasePath) -> DatabaseReference {
        var childReference = self.databaseReference
        for path in path {
            childReference = childReference.child(path)
        }
        return childReference
    }
    
    func listen(path: FirebasePath) -> Observable<FirebaseDictionary> {
        let childReference = self.childReference(of: path)
        
        return BehaviorRelay<FirebaseDictionary>.create { observer in
            childReference.observe(DataEventType.value, with: { snapshot in
                guard let data = snapshot.value as? FirebaseDictionary else {
                    return
                }
                observer.onNext(data)
            })
            return Disposables.create()
        }
    }
    
    func stopListen(path: FirebasePath) {
        let childReference = self.childReference(of: path)
        
        childReference.removeAllObservers()
    }
    
    func create(with value: Any, path: FirebasePath) -> Observable<Void> {
        let childReference = self.childReference(of: path)
        
        return Observable<Void>.create { observer in
            childReference.setValue(value) { error, _ in
                if let error {
                    observer.onError(error)
                    observer.onCompleted()
                }
                observer.onNext(())
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    func fetch(of path: FirebasePath) -> Observable<FirebaseDictionary> {
        let childReference = self.childReference(of: path)
        
        return Observable.create { observer in
            childReference.observeSingleEvent(of: .value) { snapshot, _  in
                guard let data = snapshot.value as? FirebaseDictionary else {
                    observer.onCompleted()
                    return
                }
                print(data)
                observer.onNext(data)
                observer.onCompleted()
            }
            return Disposables.create()
        }
        
    }
}
