//
//  CityChangingViewController.swift
//  WylsaMarketplace
//
//  Created by Владимир Моторкин on 06.03.2022.
//

import UIKit

import Foundation
import UIKit

protocol CityChangingViewControllerDelegate: NSObjectProtocol {
    func citySelected(controller: CityChangingViewController, kind: City)
}

class CityChangingViewController: UIViewController {
    //MARK: - Variables
    private let cities: [City] = City.allCases
    weak var customDelegate: CityChangingViewControllerDelegate?
    
    //MARK: - Controls
    private let navigationView: AnouncementNavigationView = {
        let view = AnouncementNavigationView(buttonType: .close, title: "Выбор города")
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

extension CityChangingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectProductKindCell.reuseId, for: indexPath) as? SelectProductKindCell else { return UITableViewCell()}
        cell.configure(viewModel: .init(productKindName: cities[indexPath.row].rawValue))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        customDelegate?.citySelected(controller: self, kind: cities[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
    
    
}

extension CityChangingViewController: AnouncementNavigationViewDelegate {
    func backButtonTapped(view: AnouncementNavigationView) {
        navigationController?.popViewController(animated: true)
    }
}

