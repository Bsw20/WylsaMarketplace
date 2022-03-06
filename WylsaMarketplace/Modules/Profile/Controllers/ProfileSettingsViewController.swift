//
//  ProfileSettingsViewController.swift
//  WylsaMarketplace
//
//  Created by Владимир Моторкин on 06.03.2022.
//

import UIKit

class ProfileSettingsViewController: UIViewController {
    
    private var cityField: ProductKindView!
    private var themeField: ProductKindView!
    
    public var city = "Москва"
    enum Theme: String {
        case dark = "Темная"
        case light = "Светлая"
    }
    
    public var labels = ["1 км", "2 км", "5 км", "10 км"]
    public var isActive = [false, true, false, false]
    
    
    public var theme = Theme.dark
    
    private let collectionView = UICollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: "cell")

        self.view.backgroundColor = UIColor(red: 0.142, green: 0.142, blue: 0.142, alpha: 1)
        
        let (stackView, entity1) = createEntityStackView(text: "Регион для поиска", field: city)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
        
        
        let stackView2 = UIStackView()
        stackView2.axis = .horizontal
        stackView2.spacing = 8
        
        
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView2)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
        let (stackView3, entity2) = createEntityStackView(text: "Тема оформления", field: city)
        
        stackView3.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView3)
        
        NSLayoutConstraint.activate([
            stackView3.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            stackView3.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            stackView3.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
        
        self.cityField = entity1
        self.themeField = entity2
    }
    
    func createTextLabel(text: String) -> UILabel {
        let textLabel: UILabel = {
            let label = UILabel()
            label.text = text
            label.font = UIFont(name: "CeraPro-Medium", size: 13)
            label.textColor = UIColor(red: 0.514, green: 0.514, blue: 0.514, alpha: 1)
            label.textAlignment = .left
            return label
        }()
        
        return textLabel
    }
    
    func createEntityButton(field: String) -> UIButton {
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.bordered()
            configuration.cornerStyle = .capsule
            configuration.baseForegroundColor = .white
            configuration.baseBackgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
            var container = AttributeContainer()
            container.font = UIFont(name: "CeraPro-Medium", size: 15)
            configuration.attributedTitle = AttributedString(field, attributes: container)
            //configuration.title = text
            let button = UIButton(configuration: configuration)
            button.contentHorizontalAlignment = .left
            return button
        } else {
            return UIButton()
        }
        
    }
    
    func createEntityStackView(text: String, field: String) ->  (UIStackView, ProductKindView)  {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 8
        
        let label = createTextLabel(text: "Регион для поиска")
        
        
        let kindView = ProductKindView()
        kindView.configure(viewModel: .init(productKind: field))
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(kindView)
        
     
        return (stackView, kindView)
    }
    
    func createCapsuleButton(text: String) -> UIButton {
        if #available(iOS 15.0, *) {
            var configuration = UIButton.Configuration.bordered()
            configuration.cornerStyle = .capsule
            configuration.baseForegroundColor = .white
            configuration.baseBackgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
            var container = AttributeContainer()
            container.font = UIFont(name: "CeraPro-Medium", size: 15)
            configuration.attributedTitle = AttributedString(text, attributes: container)
            //configuration.title = text
            let button = UIButton(configuration: configuration)
            button.contentHorizontalAlignment = .center
            return button
        } else {
            return UIButton()
        }
        
    }
     
    
                                                                  

}


extension ProfileSettingsViewController: UICollectionViewDelegate {
    
}

extension ProfileSettingsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        labels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ButtonCollectionViewCell
        cell.config(text: labels[indexPath.row], isActive: isActive[indexPath.row])
        return cell
    }
    
    
}
