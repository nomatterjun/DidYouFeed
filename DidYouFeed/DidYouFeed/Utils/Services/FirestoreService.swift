//
//  FirestoreService.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/13.
//

import Foundation

import Alamofire
import RxSwift

final class FirestoreService {
    
    // MARK: - Singleton
    
    static let standard = FirestoreService()
    
    // MARK: - Properties
    
    var defaultHeaders: HTTPHeaders {
        HTTPHeaders(FirestoreDefaults.defaultHeaders)
    }
    
    // MARK: - Initializer
    
    private init() { }
    
    // MARK: - Family Update/Delete
    
    func fetch(of nickname: String) {
        let url = FirestoreDefaults.baseURL + FirestoreDefaults.documentsPath
        + FirestoreCollectionPath.familyPath + "/\(nickname)"
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.prettyPrinted,
                   headers: self.defaultHeaders)
        .responseDecodable(of: FamilyDTO.self) { response in
            print(response.value)
        }
    }
    
    func save(family: Family) {
        let url = FirestoreDefaults.baseURL + FirestoreDefaults.documentsPath
        + FirestoreCollectionPath.familyPath + "/\(family.fID)"
        print(url)
        let payload = FamilyDTO(family: family)
        let bodyData = [FirestoreField.fields: payload]
        
        AF.request(url,
                   method: .patch,
                   parameters: bodyData,
                   encoder: JSONParameterEncoder.json(),
                   headers: self.defaultHeaders)
        .response { response in
            switch response.result {
            case .success(_):
                print("Success!")
            case let .failure(error):
                print(error)
            }
        }
    }
}
