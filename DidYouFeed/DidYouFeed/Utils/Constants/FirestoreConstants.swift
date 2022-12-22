//
//  FirestoreConstants.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/13.
//

import Foundation

enum FirestoreDefaults {
    static let baseURL = "https://firestore.googleapis.com/v1/projects/didyoufeed-77841"
    static let documentsPath = "/databases/(default)/documents"
    static let defaultHeaders = ["Content-Type": "application/json", "Accept": "application/json"]
}

enum FirestoreCollectionPath {
    static let familyPath = "/Family"
}

enum FirestoreField {
    /// fields
    static let fields = "fields"
}
