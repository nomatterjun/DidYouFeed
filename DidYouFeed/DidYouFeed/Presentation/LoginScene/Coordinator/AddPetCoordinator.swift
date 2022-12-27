//
//  AddPetCoordinator.swift
//  DidYouFeed
//
//  Created by 이창준 on 2022/12/23.
//

import OSLog
import PhotosUI
import UIKit

import ReactorKit
import RxSwift
import RxCocoa

final class AddPetCoordinator: Coordinator {
    typealias Reactor = AddPetReactor
    
    // MARK: - Properties
    
    private var disposeBag = DisposeBag()
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var type: CoordinatorType = .addPet
    
    let petImage = PublishRelay<UIImage>()
    
    // MARK: - Initializer
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Functions
    
    func start() {
        let addPetReactor = AddPetReactor(coordinator: self)
        let addPetViewController = AddPetViewController(reactor: addPetReactor)
        self.bind(reactor: addPetReactor)
        self.navigationController.pushViewController(addPetViewController, animated: true)
    }
    
    func finish() {
        self.finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func bind(reactor: AddPetReactor) {
        
        // Action
        self.petImage
            .asObservable()
            .map { Reactor.Action.updatePetIcon($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    func presentImagePicker() {
        var config = PHPickerConfiguration()
        config.filter = .images
        let imagePickerController = PHPickerViewController(configuration: config)
        imagePickerController.delegate = self
        DispatchQueue.main.async {
            self.navigationController.present(imagePickerController, animated: true)
        }
    }
}

extension AddPetCoordinator: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        let cgService = CoreGraphicService()
        let itemProvider = results.first?.itemProvider

        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { url, error in
                if let url {
                    let targetSize = CGSize(width: 100.0, height: 100.0)
                    guard let downsampleImage = cgService.downsample(
                        at: url,
                        to: targetSize,
                        scale: UIScreen.main.scale
                    ) else { return }
                    guard let convertedImage = UIImage(data: downsampleImage) else { return }
                    self.petImage.accept(convertedImage)
                }
                if let error {
                    os_log(.error, "\(error)")
                }
                DispatchQueue.main.async {
                    picker.dismiss(animated: true)
                }
            }
        }
    }
}
