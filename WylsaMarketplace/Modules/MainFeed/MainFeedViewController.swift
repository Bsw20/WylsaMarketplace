//
//  MainFeedViewController.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 12.02.2022.
//

import Foundation
import UIKit

class MainFeedViewController: UIViewController {
    
    var header = UIView()
    var titleLabel = UILabel()
    var profileButton = UIButton()
    var searchField = UITextField()
    var scrollView = UIScrollView()
    var stackView = UIStackView()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "so-add-circle"), for: .normal)
        
        
        
        let addAnnouncement = UIAction(title: "Добавить объявление", image: UIImage(named: "so-add-circle")) {[weak self] _ in
            guard let self = self else { return }
            print("Добавить объявление")
            self.navigationController?.present(CreateAnnouncementViewController(), animated: true, completion: nil)
        }
        
        let myOrders = UIAction(title: "Мои заказы", image: UIImage(named: "Group 696")) {[weak self] _ in
            guard let self = self else { return }
            print("Мои заказы")
            //            self.navigationController?.present(ProductDescriptionViewController(), animated: true, completion: nil)
        }
        
        let message = UIAction(title: "Сообщения", image: UIImage(named: "Group 695")) {[weak self] _ in
            guard let self = self else { return }
            print("Сообщения")
            self.navigationController?.present(ConversationsViewController(), animated: true, completion: nil)
        }
        
        button.menu = UIMenu(title: "", children: [
            message, myOrders, addAnnouncement])
        button.showsMenuAsPrimaryAction = true
        
        return button
    }()
    
    private var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.0431372549, blue: 0.0431372549, alpha: 1)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 6, bottom: 0, right: 0)
        
        return collectionView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupHeader()
        setup()
        setupHierarchy()
        setupConstrains()
    }
    
    private func setupHeader() {
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let title: UILabel = {
            let label = UILabel()
            label.text = "Барахолка"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.setStyle(style: .init(font: .ceraPro(style: .normal, size: 28),
                                        textColor: .white,
                                        textAlignment: .left))
            return label
        }()
        self.titleLabel = title
        
        let profileButton: UIButton = {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(systemName: "person.crop.circle"), for: .normal)
            button.contentVerticalAlignment = .fill
            button.contentHorizontalAlignment = .fill
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            return button
        }()
        self.profileButton = profileButton
        
        let field: UITextField = {
            let field = UITextField()
            field.placeholder = "Поиск в Москва"
            field.translatesAutoresizingMaskIntoConstraints = false
            field.backgroundColor = .grey1
            field.font = UIFont.ceraPro(style: .normal, size: 18)
            field.textColor = .gray2
            field.layer.cornerRadius = 8
            field.setIcon(UIImage(systemName: "magnifyingglass"))
            return field
        }()
        
        self.searchField = field
        
        
        profileButton.addTarget(self, action: #selector(showProfileView), for: .touchUpInside)
        
        
        
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let labels = ["iPhone", "iPad", "MacBook", "Аксессуары"]
        
        let buttons = (labels).map {createCapsuleButton(text: $0) }
        var sum: CGFloat = 0
        for button in buttons {
            stackView.addArrangedSubview(button)
            sum += button.frame.width
        }
        
        
        
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        self.stackView = stackView
        
        
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: sum, height: 30)
        
        
        self.scrollView = scrollView
        containerView.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.stackView)
        
        
        containerView.addSubview(self.titleLabel)
        containerView.addSubview(self.profileButton)
        containerView.addSubview(self.searchField)
        
        
        
        
        self.header = containerView
    }
    
    func createCapsuleButton(text: String) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 24
        button.titleLabel?.font = UIFont.ceraPro(style: .normal, size: 15)
        button.setTitle(text, for: .normal)
        button.backgroundColor = .grey1
        return button
    }
    
    private func createSearchController() -> UISearchController {
        let searchController = UISearchController()
        searchController.delegate = self
        searchController.searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchController.searchBar.compatibleSearchTextField.backgroundColor = UIColor.black
        return searchController
        
    }
    
    @objc func showProfileView() {
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    private func setup() {
        view.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.0431372549, blue: 0.0431372549, alpha: 1)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(MainFeedCollectionCell.self, forCellWithReuseIdentifier: MainFeedCollectionCell.reuseId)
    }
    
    private func setupHierarchy() {
        view.addSubview(header)
        view.addSubview(mainCollectionView)
        view.addSubview(plusButton)
    }
    
    private func setupConstrains() {
        
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: header.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            profileButton.rightAnchor.constraint(equalTo: header.rightAnchor, constant: -30),
            profileButton.heightAnchor.constraint(equalToConstant: 40),
            profileButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 16),
            searchField.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 10),
            searchField.rightAnchor.constraint(equalTo: header.rightAnchor, constant: -10),
            searchField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: header.rightAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: header.bottomAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            header.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            header.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            header.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            mainCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            mainCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            mainCollectionView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            plusButton.heightAnchor.constraint(equalToConstant: 58),
            plusButton.widthAnchor.constraint(equalToConstant: 58),
            plusButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -17),
            plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -17)
        ])
    }
}

extension MainFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainFeedCollectionCell.reuseId, for: indexPath) as? MainFeedCollectionCell else { return UICollectionViewCell()}
        cell.customDelegate = self
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: MainFeedCollectionCell.preferredHeight)
    }
}

extension MainFeedViewController: MainFeedCollectionCellDelegate {
    func chatToSellerButtonTapped(cell: MainFeedCollectionCell) {
        present(OpenedProductCardViewController(), animated: true, completion: nil)
    }
}

extension MainFeedViewController: UISearchControllerDelegate {
    
}

extension UISearchBar {
    
    // Due to searchTextField property who available iOS 13 only, extend this property for iOS 13 previous version compatibility
    var compatibleSearchTextField: UITextField {
        guard #available(iOS 13.0, *) else { return legacySearchField }
        return self.searchTextField
    }
    
    private var legacySearchField: UITextField {
        if let textField = self.subviews.first?.subviews.last as? UITextField {
            // Xcode 11 previous environment
            return textField
        } else if let textField = self.value(forKey: "searchField") as? UITextField {
            // Xcode 11 run in iOS 13 previous devices
            return textField
        } else {
            // exception condition or error handler in here
            return UITextField()
        }
    }
}

extension UITextField {
    func setIcon(_ image: UIImage?) {
        let iconView = UIImageView(frame:
                                    CGRect(x: 10, y: 5, width: 20, height: 20))
        iconView.image = image
        iconView.tintColor = .gray2
        let iconContainerView: UIView = UIView(frame:
                                                CGRect(x: 20, y: 0, width: 30, height: 30))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}
