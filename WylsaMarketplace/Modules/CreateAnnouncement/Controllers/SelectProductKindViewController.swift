//
//  SelectProductKindViewController.swift
//  WylsaMarketplace
//
//  Created by Ярослав Карпунькин on 03.03.2022.
//

import Foundation
import UIKit

protocol SelectProductKindViewControllerDelegate: NSObjectProtocol {
    func kindSelected(controller: SelectProductKindViewController, kind: ProductKind)
}

class SelectProductKindViewController: UIViewController {
    //MARK: - Variables
    private let kinds: [ProductKind] = ProductKind.allCases
    weak var customDelegate: SelectProductKindViewControllerDelegate?
    
    //MARK: - Controls
    private let navigationView: AnouncementNavigationView = {
        let view = AnouncementNavigationView(buttonType: .close, title: "Выберите категорию")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var mainTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .bg1
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .bg1
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupHierarchy()
        setupConstrains()
    }
    
    private func setup() {
        view.backgroundColor = .bg1
        navigationView.customDelegate = self
        setupCollection()
    }
    
    private func setupCollection() {
        mainTable.delegate = self
        mainTable.dataSource = self
        mainTable.register(SelectProductKindCell.self, forCellReuseIdentifier: SelectProductKindCell.reuseId)
    }
    
    private func setupHierarchy() {
        view.addSubview(navigationView)
        view.addSubview(mainTable)
    }
    
    private func setupConstrains() {
        navigationView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(53)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().inset(20)
        }
        
        mainTable.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(navigationView.snp.bottom)
        }
    }
}

extension SelectProductKindViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kinds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectProductKindCell.reuseId, for: indexPath) as? SelectProductKindCell else { return UITableViewCell()}
        cell.configure(viewModel: .init(productKindName: kinds[indexPath.row].rawValue))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        customDelegate?.kindSelected(controller: self, kind: kinds[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension SelectProductKindViewController: AnouncementNavigationViewDelegate {
    func backButtonTapped(view: AnouncementNavigationView) {
        self.dismiss(animated: true, completion: nil)
    }
}
