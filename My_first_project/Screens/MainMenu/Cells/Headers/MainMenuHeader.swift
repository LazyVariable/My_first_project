//
//  HeadBarMenu.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 17.12.2022.
//

import UIKit
import SnapKit

protocol OpenSideBarViewDelegate: AnyObject {
    func didTapSideMenuButton()
}

protocol OpenChooseFundsViewDelegate: AnyObject {
    func didTapChooseFundsButton()
}

class MainMenuHeader: UITableViewHeaderFooterView {
    
    private func totalData (_ funds: [Funds], _ expenses: [Expenses], _ plans: [Expenses]) -> (Float, Float, Float) {
        let funds = funds.compactMap { Float($0.balance) }.reduce(0,+)
        let expenses = expenses.compactMap { Float($0.amount) }.reduce(0,+)
        let plans = (plans.compactMap { Float($0.plan) }.reduce(0,+)) - expenses
        
        return(funds, expenses, plans)
    }
    
    static var reuseId = "MainMenuHeader"
    
    weak var delegateOpenSide: OpenSideBarViewDelegate?
    
    weak var delegateOpenFundsChoose: OpenChooseFundsViewDelegate?
    
    private lazy var sideMenuButton: UIButton = {
        var button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "list.bullet"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(didTapSideMenuButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var balanceLabel: UILabel = {
        var label = LabelFactory()
        label.categoryNameLabel.text = "Баланс\nBr 0.0"
        
        return label.categoryNameLabel
    }()
    
    private lazy var expensesLabel: UILabel = {
        var label = LabelFactory()
        label.categoryNameLabel.text = "Расходы\nBr 0.0"
        
        return label.categoryNameLabel
    }()
    
    private lazy var plansLabel: UILabel = {
        var label = LabelFactory()
        label.categoryNameLabel.text = "В планах\nBr 0.0"
        
        return label.categoryNameLabel
    }()
    
    private lazy var incomeButton: UIButton = {
        var button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(openChooseFundsView), for: .touchUpInside)
        return button
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Pablic
    
    func configure(_ funds: [Funds], _ expenses: [Expenses], _ plans: [Expenses]) {
        let tuple = totalData(funds, expenses, plans)
        balanceLabel.text = String(format: "Баланс\nBr %.2f", tuple.0)
        expensesLabel.text = "Расходы\nBr \(tuple.1)"
        plansLabel.text = "В планах\nBr \(tuple.2)"
    }
    
    // MARK: - Privatre
    private func setupViews() {
        
        self.addSubview(sideMenuButton)
        self.addSubview(balanceLabel)
        self.addSubview(expensesLabel)
        self.addSubview(plansLabel)
        self.addSubview(incomeButton)
        self.backgroundColor = .systemPink
        
    }
    
    private func setupConstraints() {
        sideMenuButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-20)
            make.left.bottom.equalTo(self).inset(15)
            make.height.width.equalTo(40)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.left.equalTo(sideMenuButton.snp.right)
            make.top.equalTo(sideMenuButton.snp.top)
            make.centerY.equalTo(sideMenuButton.snp.centerY)
        }
        
        expensesLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(sideMenuButton.snp.centerY)
            make.left.equalTo(balanceLabel.snp.right)
            make.right.equalTo(plansLabel.snp.left)
        }
        plansLabel.snp.makeConstraints { make in
            make.right.equalTo(incomeButton.snp.left)
            make.centerY.equalTo(sideMenuButton.snp.centerY)
        }
        incomeButton.snp.makeConstraints { make in
            
            make.right.bottom.equalTo(self).inset(15)
            make.height.width.equalTo(40)
        }
        
    }
    
    // MARK: - Actions
    
    @objc func didTapSideMenuButton() {
        delegateOpenSide?.didTapSideMenuButton()
        print("changeScreenSideMenu")
    }
    @objc func openChooseFundsView() {
        delegateOpenFundsChoose?.didTapChooseFundsButton()
        print("changeScreenToChooseFunds")
    }
}

