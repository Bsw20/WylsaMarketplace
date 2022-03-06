//
//  CreateAnnouncementViewController.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 22.02.2022.
//


import Foundation
import UIKit

struct CreateAnnouncementViewControllerViewModel {
    var productKind: ProductKind
    var images: [UIImage]
}

class CreateAnnouncementViewController: UIViewController {
    //MARK: - Variables
    private var viewModel: CreateAnnouncementViewControllerViewModel = .init(productKind: .iphone, images: [#imageLiteral(resourceName: "PhotoCollectionStubImage")])
    
    //MARK: - Controls
    private let imagePicker = UIImagePickerController()
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .bg1
        return view
    }()
    
    private var mainCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .bg1
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupHierarchy()
        setupConstrains()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.isNavigationBarHidden = true
//    }
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        navigationController?.isNavigationBarHidden = false
//    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillShow(notification:)),
                                             name: UIResponder.keyboardWillShowNotification,
                                             object: nil)
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(keyboardWillHide(notification:)),
                                             name: UIResponder.keyboardWillHideNotification,
                                             object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardSize = keyboardInfo.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        mainCollection.contentInset = contentInsets
        mainCollection.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        mainCollection.contentInset = .zero
        mainCollection.scrollIndicatorInsets = .zero
    }
    
    
    private func setup() {
        view.backgroundColor = .bg1
        setupCollection()
        hideKeyboardWhenTappedAround()
        //        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    private func setupCollection() {
        mainCollection.delegate = self
        mainCollection.dataSource = self
        
        mainCollection.register(ProductPhotoCollectionCell.self, forCellWithReuseIdentifier: ProductPhotoCollectionCell.reuseId)
        mainCollection.register(AddPhotoCollectionCell.self, forCellWithReuseIdentifier: AddPhotoCollectionCell.reuseId)
        mainCollection.register(PhotosCollectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PhotosCollectionHeader.reuseId)
        mainCollection.register(PhotosCollectionFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: PhotosCollectionFooter.reuseId)
    }
    
    private func setupHierarchy() {
        view.addSubview(mainCollection)
    }
    
    private func setupConstrains() {
        mainCollection.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension CreateAnnouncementViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddPhotoCollectionCell.reuseId, for: indexPath) as! AddPhotoCollectionCell
            cell.customDelegate = self
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductPhotoCollectionCell.reuseId, for: indexPath) as! ProductPhotoCollectionCell
        cell.configure(viewModel: .init(image: viewModel.images[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 45) / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(
              ofKind: kind,
                withReuseIdentifier: PhotosCollectionHeader.reuseId,
              for: indexPath) as! PhotosCollectionHeader
            headerView.customDelegate = self
            headerView.configure(viewModel: .init(productKind: viewModel.productKind))
            
            return headerView
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(
              ofKind: kind,
                withReuseIdentifier: PhotosCollectionFooter.reuseId,
              for: indexPath) as! PhotosCollectionFooter
            footerView.customDelegate = self
            return footerView
        default:
           return  UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)

        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required, // Width is fixed
                                                  verticalFittingPriority: .fittingSizeLevel) // Height can be as large as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let footerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionFooter, at: indexPath)

        return footerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required, // Width is fixed
                                                  verticalFittingPriority: .fittingSizeLevel) // Height can be as large as needed
    }
}

extension CreateAnnouncementViewController: PhotosCollectionFooterDelegate {
    func nextButtonTapped(view: PhotosCollectionFooter) {
        let vc = SetCostViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension CreateAnnouncementViewController: PhotosCollectionHeaderDelegate {
    func productKindViewTapped(view: PhotosCollectionHeader) {
        let controller = SelectProductKindViewController()
        controller.customDelegate = self
        present(controller, animated: true, completion: nil)
    }
    
    func backButtonTapped(view: PhotosCollectionHeader) {
        dismiss(animated: true, completion: nil)
    }
}

extension CreateAnnouncementViewController: SelectProductKindViewControllerDelegate {
    func kindSelected(controller: SelectProductKindViewController, kind: ProductKind) {
        viewModel.productKind = kind
        mainCollection.reloadData()
    }
}


extension CreateAnnouncementViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerBtnAction() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Камера",
                                      style: .default,
                                      handler: { _ in
                                        self.openCamera()
                                      }))

        alert.addAction(UIAlertAction(title: "Галерея",
                                      style: .default,
                                      handler: { _ in
                                        self.openGallery()
                                      }))

        alert.addAction(UIAlertAction(title: "Отмена",
                                      style: .cancel,
                                      handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Ошибка",
                                          message: "Камера недоступна",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Ошибка",
                                          message: "Галерея недоступна",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: false, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        var resultImage: UIImage? = nil
        if let image = info[.originalImage] as? UIImage {
            resultImage = image
        } else if let image = info[.editedImage] as? UIImage {
            resultImage = image
        }
        if let image = resultImage {
            viewModel.images.append(image)
            DispatchQueue.main.async {[weak self] in
                self?.mainCollection.reloadData()
            }
        }
       
        picker.dismiss(animated: true, completion: nil)
    }
}


extension CreateAnnouncementViewController: AddPhotoCollectionCellDelegate {
    func addButtonTapped(view: AddPhotoCollectionCell) {
        imagePickerBtnAction()
    }
}
