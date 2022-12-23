//
//  FirebaseStoreService.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/24.
//

import UIKit

import FirebaseStorage

final class FirebaseStorageService {
    
    // MARK: - Singleton
    
    static let standard = FirebaseStorageService()
    
    // MARK: - Initializer
    
    private init() { }
    
    // MARK: - Functions
    
    func upload(image: UIImage, completion: @escaping (URL?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        let imageName = UUID().uuidString + String(Date().timeIntervalSinceReferenceDate)
        
        let firebaseReference = Storage.storage().reference().child("\(imageName)")
        firebaseReference.putData(imageData, metadata: metaData) { metaData, error in
            firebaseReference.downloadURL { url, _ in
                completion(url)
            }
        }
    }
    
    func download(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let reference = Storage.storage().reference(forURL: url.absoluteString)
        let megaByte = Int64(1 * 1024 * 1024)
        
        reference.getData(maxSize: megaByte) { data, error in
            guard let imageData = data else {
                completion(nil)
                return
            }
            completion(UIImage(data: imageData))
        }
    }
}
