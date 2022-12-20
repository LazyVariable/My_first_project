//
//  ViewController.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 20.12.2022.
//

import UIKit
import SnapKit

protocol SideMenuVCDelegate: AnyObject {
    func didSelect(menuItem: MenuOptions)
}

enum MenuOptions: String, CaseIterable {
    case main = "Home"
    case info = "Information"
    case shareApp = "Share App"
    case settings = "Settings"
    
    var imageName: String {
        switch self {
            
        case .main:
            return "house"
        case .info:
            return "info"
        case .shareApp:
            return "square.and.arrow.up"
        case .settings:
            return "gearshape"
        }
    }
}

weak var delegate: SideMenuVCDelegate?

final class SideMenuVC: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = nil
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    //MARK: - Lifcycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Private
    
    private func setupViews() {
        view.addSubview(tableView)
        view.backgroundColor = CustomColors.gray
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SideMenuVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        cell.imageView?.tintColor = .white
        cell.backgroundColor = CustomColors.gray
        cell.contentView.backgroundColor = CustomColors.gray
        
        return cell
    }
}

extension SideMenuVC: UITableViewDelegate {
    
}
