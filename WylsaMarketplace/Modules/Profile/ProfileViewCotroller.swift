//
//  ProfileViewCotroller.swift
//  WylsaMarketplace
//
//  Created by Владимир Моторкин on 06.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    public let name = "Ivan"
    public let imageURL = ""
    
    private var profileImageView: UIImageView!
    private var profileLabel: UILabel!
    private var editButton: UIButton!
    private var myOrdersButton: UIButton!
    private var myAdvertsButton: UIButton!
    private var deleteProfileButton: UIButton!
    private var deleteLabel: UILabel!
    private var exitButton: UIButton!
    
    private let imagePicker = UIImagePickerController()
    
    private var navigationView: ProfileNavigationView = {
        let view = ProfileNavigationView(buttonType: .close, title: "Профиль")
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationView.customDelegate = self
        
        setupView()
        setupConstraints()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor(red: 0.142, green: 0.142, blue: 0.142, alpha: 1)
        
        navigationView.backgroundColor = view.backgroundColor
        
        let profileImageView: UIImageView = {
            let profileImageView = UIImageView()
            profileImageView.layer.borderWidth = 1
            profileImageView.layer.masksToBounds = false
            profileImageView.layer.borderColor = UIColor.black.cgColor
            profileImageView.layer.cornerRadius = 75
            profileImageView.clipsToBounds = true
            profileImageView.image = UIImage(named: "avatar")
            //profileImageView.backgroundColor = .red
            return profileImageView
        }()
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageTap))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(singleTap)
        self.profileImageView = profileImageView
        
        let profileLabel: UILabel = {
            let label = UILabel()
            label.text = name
            label.font = UIFont(name: "CeraPro-Medium", size: 22)
            label.textColor = .white
            label.textAlignment = .center
            return label
        }()
        self.profileLabel = profileLabel
        
        let editButton = configButton(text: "Редактирование профиля")
        editButton.addTarget(self, action: #selector(editProfile), for: .touchUpInside)
        self.editButton = editButton
    
        let myOrdersButton = configButton(text: "Мои заказы")
        self.myOrdersButton = myOrdersButton
        
        let myAdvertsButton = configButton(text: "Мои объявления")
        self.myAdvertsButton = myAdvertsButton
        
        let deleteProfileButton = configButton(text: "Удалить профиль", colorStyle: .red)
        deleteProfileButton.addTarget(self, action: #selector(deleteAccount), for: .touchUpInside)
        self.deleteProfileButton = deleteProfileButton
        
        let deleteLabel: UILabel = {
            let deleteLabel = UILabel()
            deleteLabel.text = "Все данные будут стёрты"
            deleteLabel.textColor = UIColor(red: 0.514, green: 0.514, blue: 0.514, alpha: 1)
            deleteLabel.textAlignment = .left
            deleteLabel.font = UIFont(name: "CeraPro-Medium", size: 11)
            return deleteLabel
        }()
        self.deleteLabel = deleteLabel
       
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.bordered()
            configuration.baseForegroundColor = .white
            var container = AttributeContainer()
            container.font = UIFont(name: "CeraPro-Medium", size: 15)
            configuration.attributedTitle = AttributedString("Выйти", attributes: container)
            //configuration.title = text
            let button = UIButton(configuration: configuration)
            button.backgroundColor = UIColor(red: 0.145, green: 0.714, blue: 0.349, alpha: 1)
            button.layer.cornerRadius = 8
            self.exitButton = button
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    
    
    @objc func editProfile() {
        let editProfileViewController = EditProfileViewController()
        editProfileViewController.field = name
        self.navigationController?.pushViewController(editProfileViewController, animated: true)
    }
    
    @objc func deleteAccount() {
            let alert = UIAlertController()

            alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { (_) in
                print("User click Delete button")
            }))

            alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { (_) in
                print("User click Dismiss button")
            }))

            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }
    
    @objc func imageTap() {
        let alert = UIAlertController()
        alert.addAction(UIAlertAction(title: "Изменить фотографию", style: .default, handler: { (_) in
            self.imagePickerBtnAction()
            print("User click Change button")
        }))

        alert.addAction(UIAlertAction(title: "Удалить фотографию", style: .destructive, handler: { (_) in
            self.profileImageView.image = UIImage(named: "avatar")
            print("User click Delete button")
        }))
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))
        

        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    func setupConstraints() {
        view.addSubview(navigationView)
        view.addSubview(profileImageView)
        view.addSubview(profileLabel)
        view.addSubview(editButton)
        view.addSubview(myOrdersButton)
        view.addSubview(myAdvertsButton)
        view.addSubview(deleteProfileButton)
        view.addSubview(deleteLabel)
        view.addSubview(exitButton)
        
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            profileImageView.widthAnchor.constraint(equalToConstant: 150),
            profileImageView.heightAnchor.constraint(equalToConstant: 150),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
            profileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            editButton.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 24),
            editButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            editButton.heightAnchor.constraint(equalToConstant: 45),
        ])
        
        myOrdersButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myOrdersButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            myOrdersButton.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: 8),
            myOrdersButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            myOrdersButton.heightAnchor.constraint(equalToConstant: 45),
        ])
        
        myAdvertsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myAdvertsButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            myAdvertsButton.topAnchor.constraint(equalTo: myOrdersButton.bottomAnchor, constant: 8),
            myAdvertsButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            myAdvertsButton.heightAnchor.constraint(equalToConstant: 45),
        ])
        
        deleteProfileButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteProfileButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            deleteProfileButton.topAnchor.constraint(equalTo: myAdvertsButton.bottomAnchor, constant: 16),
            deleteProfileButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            deleteProfileButton.heightAnchor.constraint(equalToConstant: 45),
        ])
        
        deleteLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteLabel.topAnchor.constraint(equalTo: deleteProfileButton.bottomAnchor, constant: 8),
            deleteLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            deleteLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ])
        
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -98),
            exitButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            exitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            exitButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    func configButton(text: String, colorStyle: UIColor = UIColor(red: 0.514, green: 0.514, blue: 0.514, alpha: 1)) -> UIButton {
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.bordered()
            configuration.baseForegroundColor = colorStyle
            configuration.contentInsets.leading = 8
            var container = AttributeContainer()
            container.font = UIFont(name: "CeraPro-Medium", size: 15)
            configuration.attributedTitle = AttributedString(text, attributes: container)
            //configuration.title = text
            let button = UIButton(configuration: configuration)
            
            button.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
            button.layer.cornerRadius = 8
            button.contentHorizontalAlignment = .leading
            return button
        } else {
            return UIButton()
            // Fallback on earlier versions
        }
        
    }


}

extension ProfileViewController: ProfileNavigationViewDelegate {
    func backButtonTapped(view: ProfileNavigationView) {
        navigationController?.popViewController(animated: true)
    }
    
    func settingsButtonTapped(view: ProfileNavigationView) {
        self.navigationController?.pushViewController(ProfileSettingsViewController(), animated: true)
    }
    
    
}


extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
            profileImageView.image = image
        }
       
        picker.dismiss(animated: true, completion: nil)
    }
}
