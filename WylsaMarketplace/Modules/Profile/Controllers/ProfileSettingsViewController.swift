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
    
    public var theme = Theme.dark
    
    public var labels = ["1 км", "2 км", "5 км", "10 км"]
    public var isActive = [false, true, false, false]
    private var lastActive = 1
    
    private var stackView = UIStackView()
    private var stackView2 = UIStackView()
    private var stackView3 = UIStackView()
    
    private var navigationView: DoneNavigationView = {
        let view = DoneNavigationView(title: "Настройка аккаунта")
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationView.customDelegate = self
        
        self.view.addSubview(navigationView)
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: (self.view.frame.width), height: 36), collectionViewLayout: UICollectionViewFlowLayout.init())
        
        collectionView.backgroundColor = .bg1
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.itemSize = CGSize(width: 78, height: 36)
        }
        

        self.view.backgroundColor = .bg1
        
        let (stackView, entity1) = createEntityStackView(text: "Регион для поиска", field: city)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView = stackView
        self.view.addSubview(self.stackView)
        
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            self.stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            self.stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
        
        self.view.addSubview(collectionView)
        
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 36),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        let (stackView3, entity2) = createEntityStackView(text: "Тема оформления", field: theme.rawValue)
        
        
        stackView3.translatesAutoresizingMaskIntoConstraints = false
        self.stackView3 = stackView3
        self.view.addSubview(self.stackView3)
        
        NSLayoutConstraint.activate([
            self.stackView3.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor, constant: 16),
            self.stackView3.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            self.stackView3.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ])
        
        
        
        self.cityField = entity1
        self.themeField = entity2
        
        cityField.customDelegate = self
    }
    
    func createTextLabel(text: String) -> UILabel {
        let textLabel: UILabel = {
            let label = UILabel()
            label.text = text
            label.font = UIFont.ceraPro(style: .normal, size: 13)
            label.textColor = UIColor(red: 0.514, green: 0.514, blue: 0.514, alpha: 1)
            label.textAlignment = .left
            return label
        }()
        
        return textLabel
    }
    
    func createEntityButton(field: String) -> UIButton {
//        if #available(iOS 15.0, *) {
//            var configuration = UIButton.Configuration.bordered()
//            configuration.cornerStyle = .capsule
//            configuration.baseForegroundColor = .white
//            configuration.baseBackgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
//            var container = AttributeContainer()
//            container.font = UIFont.ceraPro(style: .normal, size: 15)
//            configuration.attributedTitle = AttributedString(field, attributes: container)
//            //configuration.title = text
//            let button = UIButton(configuration: configuration)
//            button.contentHorizontalAlignment = .left
//            return button
//        } else {
//            return UIButton()
//        }
        return UIButton()
        
    }
    
    func createEntityStackView(text: String, field: String) ->  (UIStackView, ProductKindView)  {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.spacing = 8
        
        let label = createTextLabel(text: text)
        
        
        let kindView = ProductKindView()
        kindView.configure(viewModel: .init(productKind: field))
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(kindView)
        
        NSLayoutConstraint.activate([
            kindView.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            kindView.leftAnchor.constraint(equalTo: stackView.leftAnchor)
        ])
        
        return (stackView, kindView)
    }
    
    func createCapsuleButton(text: String) -> UIButton {
//        if #available(iOS 15.0, *) {
//            var configuration = UIButton.Configuration.bordered()
//            configuration.cornerStyle = .capsule
//            configuration.baseForegroundColor = .white
//            configuration.baseBackgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.118, alpha: 1)
//            var container = AttributeContainer()
//            container.font = UIFont.ceraPro(style: .normal, size: 15)
//            configuration.attributedTitle = AttributedString(text, attributes: container)
//            //configuration.title = text
//            let button = UIButton(configuration: configuration)
//            button.contentHorizontalAlignment = .center
//            return button
//        } else {
            return UIButton()
//        }
        
    }
     
    
                                                                  

}


extension ProfileSettingsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isActive[lastActive].toggle()
        let index = indexPath.row
        lastActive = index
        isActive[index].toggle()
        print(index)
        collectionView.reloadData()
    }
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

extension ProfileSettingsViewController: DoneNavigationViewDelegate {
    func doneButtonTapped(view: DoneNavigationView) {
        navigationController?.popViewController(animated: true)
    }
}

extension ProfileSettingsViewController: ProductKindViewDelegate {
    func viewTapped(view: ProductKindView) {
        let controller = CityChangingViewController()
        controller.customDelegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ProfileSettingsViewController: CityChangingViewControllerDelegate {
    func citySelected(controller: CityChangingViewController, kind: City) {
        cityField.configure(viewModel: .init(productKind: kind.rawValue))
    }
    
}
