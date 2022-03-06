//
//  EditProfileViewCotroller.swift
//  WylsaMarketplace
//
//  Created by Владимир Моторкин on 06.03.2022.
//


import UIKit

class EditProfileViewController: UIViewController {

    public var field = ""
    
    private var nameField: UITextField!
    
    private var navigationView: DoneNavigationView = {
        let view = DoneNavigationView(title: "Настройка профиля")
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.overrideUserInterfaceStyle = .dark
        
        navigationView.customDelegate = self
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = .bg1
        
        self.view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        let stackView = createEntityStackView(text: "Имя профиля", field: field)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
    }
    
    func createEntityStackView(text: String, field: String ) ->  UIStackView {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 8
        
        let textLabel: UILabel = {
            let label = UILabel()
            label.text = text
            label.font = UIFont.ceraPro(style: .normal, size: 13)
            label.textColor = UIColor(red: 0.514, green: 0.514, blue: 0.514, alpha: 1)
            label.textAlignment = .left
            return label
        }()
        
        let entityField: UITextField = {
            let textField = UITextField()
            textField.layer.cornerRadius = 8
            textField.font = UIFont.ceraPro(style: .normal, size: 15)
            textField.textColor = UIColor(red: 0.514, green: 0.514, blue: 0.514, alpha: 1)
            textField.text = field
            textField.layer.sublayerTransform = CATransform3DMakeTranslation(8, 0, 0)
            textField.backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
            textField.textColor = UIColor(red: 0.514, green: 0.514, blue: 0.514, alpha: 1)
            return textField
        }()
        
        self.nameField = entityField
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        entityField.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(textLabel)
        stackView.addArrangedSubview(entityField)
        NSLayoutConstraint.activate([
            entityField.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            entityField.heightAnchor.constraint(equalToConstant: 45),
            entityField.rightAnchor.constraint(equalTo: stackView.rightAnchor)
        ])
        
     
        return stackView
    }
    
    
    

}

extension EditProfileViewController: DoneNavigationViewDelegate {    
    func doneButtonTapped(view: DoneNavigationView) {
        navigationController?.popViewController(animated: true)
    }
}
