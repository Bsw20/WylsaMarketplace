//
//  ConversationsViewController.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 05.03.2022.
//

import Foundation
import UIKit

class ConversationsViewController: UIViewController {
    //MARK: - Variables
    
    //MARK: - Controls
    private var navigationView: AnouncementNavigationView = {
        let view = AnouncementNavigationView(buttonType: .back, title: "Сообщения")
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var searchBar: UISearchBar = {
       let view = UISearchBar()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .bg1
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupHierarchy()
        setupConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    private func setup() {
        
        view.backgroundColor = .bg1
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationView.customDelegate = self
        setupTable()
    }
    
    private func setupTable() {
        tableView.register(ConversationCell.self, forCellReuseIdentifier: ConversationCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
//        tableView.tableHeaderView = searchBar
        tableView.addSubview(searchBar)
    }
    
    private func setupHierarchy() {
        view.addSubview(navigationView)
        view.addSubview(tableView)
    }
    
    private func setupConstrains() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationView.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
}


//MARK: - UITableViewDelegate&UITableViewDataSource
extension ConversationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationCell.reuseId, for: indexPath) as! ConversationCell
//        cell.configure(model: conversations[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CGFloat(84)
        return 92
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(PersonalChatViewController(), animated: true)
    }
    
//    spacing
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let conversation = conversations[indexPath.row]
//        router?.routeToChat(conversation: conversation, userInfo: myProfileInfo)
//    }
    
    
}

extension ConversationsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

    }
}

extension ConversationsViewController: AnouncementNavigationViewDelegate {
    func backButtonTapped(view: AnouncementNavigationView) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
