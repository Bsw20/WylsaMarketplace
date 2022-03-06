//
//  MainFeedViewController.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 12.02.2022.
//

import Foundation
import UIKit

class MainFeedViewController: UIViewController {
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "so-add-circle"), for: .normal)
        
        let addAnnouncement = UIAction(title: "Добавить объявление", image: UIImage(named: "so-add-circle")) {[weak self] _ in
            guard let self = self else { return }
            print("Добавить объявление")
            let vc = UINavigationController(rootViewController: CreateAnnouncementViewController())
            vc.isNavigationBarHidden = true
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
        
        let myOrders = UIAction(title: "Мои заказы", image: UIImage(named: "Group 696")) {[weak self] _ in
            guard let self = self else { return }
            print("Мои заказы")
//            self.navigationController?.present(ProductDescriptionViewController(), animated: true, completion: nil)
        }
        
        let message = UIAction(title: "Сообщения", image: UIImage(named: "Group 695")) {[weak self] _ in
            guard let self = self else { return }
            print("Сообщения")
            let controller = ConversationsViewController()
            controller.hidesBottomBarWhenPushed = true
            self.navigationController?.pushViewController(controller, animated: true)
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

        setup()
        setupHierarchy()
        setupConstrains()
    }
    
    private func setup() {
        view.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.0431372549, blue: 0.0431372549, alpha: 1)
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        mainCollectionView.register(MainFeedCollectionCell.self, forCellWithReuseIdentifier: MainFeedCollectionCell.reuseId)
    }
    
    private func setupHierarchy() {
        view.addSubview(mainCollectionView)
        view.addSubview(plusButton)
    }
    
    private func setupConstrains() {
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        plusButton.snp.makeConstraints { make in
            make.height.width.equalTo(58)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(17)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(17)
        }
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
//        present(OpenedProductCardViewController(), animated: true, completion: nil)
        let controller = OpenedProductCardViewController()
        controller.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(controller, animated: true)
    }
}
