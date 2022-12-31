//
//  MainVC.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 27.11.2022.
//

import UIKit
import SnapKit

enum SectionType: Int, CaseIterable {
    case fundsSection    //секция со счетами
    case expensesSection //секция с расходами
}

class MainMenuVC: UIViewController {
    
    var dataProvider: DataProvider
    
    var funds: [Funds] = []
    var expenses: [Expenses] = []
    var plans: [Expenses] = []
    
    lazy var tableViewHeader = MainMenuHeader()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .singleLine
        
        tableView.isScrollEnabled = false
        
        tableView.register(MainMenuHeader.self, forHeaderFooterViewReuseIdentifier: MainMenuHeader.reuseId)
        tableView.register(FundsCell.self, forCellReuseIdentifier: FundsCell.reuseId)
        tableView.register(ExpensesCell.self, forCellReuseIdentifier: ExpensesCell.reuseId)
        
        return tableView
    }()
    
    // MARK: - Lifecycle
    init(_ dataProvider: DataProvider) {
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        fetchLocalItems()
    }
    
    // MARK: - Request
    func fetchLocalItems() {
        funds = dataProvider.loadFunds() ?? []
        expenses = dataProvider.loadExpenses() ?? []
        plans = dataProvider.loadPlans() ?? []
        tableView.reloadData()
    }
    
    // MARK: - Private
    private func setupViews() {
        view.addSubview(tableView)
        
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MainMenuVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = self.tableViewHeader
        view.configure(funds, expenses, plans)
        let sectionType = SectionType.init(rawValue: section)
        switch sectionType {
        case .fundsSection: return view
        default: return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let sectionType = SectionType.init(rawValue: indexPath.row) {
            
            switch sectionType {
            case .fundsSection:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: FundsCell.reuseId, for: indexPath) as? FundsCell else { return UITableViewCell() }
                cell.configure(funds)
                cell.fundsCollectionView.reloadData()
                
                return cell
                
            case .expensesSection:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: ExpensesCell.reuseId, for: indexPath) as? ExpensesCell else { return UITableViewCell() }
                cell.configure(expenses)
                cell.expensesCollectionView.reloadData()
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
}

extension MainMenuVC: UITableViewDelegate {
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return CGFloat(tableView.bounds.height)
    //    }
}
