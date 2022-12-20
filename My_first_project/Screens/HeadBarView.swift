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

class HeadBarView: UIView {
    
    weak var delegate: OpenSideBarViewDelegate?
    
    private lazy var sideMenuButton: UIButton = {
        var button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "list.bullet"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(didTapSideMenuButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var balanceLabel: UILabel = {
        var label = LabelFactory()
        label.categoryNameLabel.text = "Баланс\nBr 999"
        
        return label.categoryNameLabel
    }()
    
    private lazy var expensesLabel: UILabel = {
        var label = LabelFactory()
        label.categoryNameLabel.text = "Расходы\nBr 666"
        
        return label.categoryNameLabel
    }()
    
    private lazy var plansLabel: UILabel = {
        var label = LabelFactory()
        label.categoryNameLabel.text = "В планах\nBr 123"
        
        return label.categoryNameLabel
    }()
    
    private lazy var incomeButton: UIButton = {
        var button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Privatre
    private func setupViews() {
        
        self.addSubview(sideMenuButton)
        self.addSubview(balanceLabel)
        self.addSubview(expensesLabel)
        self.addSubview(plansLabel)
        self.addSubview(incomeButton)
        self.backgroundColor = .white
    }
    
    private func setupConstraints() {
        sideMenuButton.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.bottom.equalTo(self).inset(15)
            make.height.width.equalTo(40)
        }
        
        balanceLabel.snp.makeConstraints { make in
            make.left.equalTo(sideMenuButton.snp.right)
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
            make.top.equalTo(self)
            make.right.bottom.equalTo(self).inset(15)
            make.height.width.equalTo(40)
        }
        
    }
    // MARK: - Public
    func configure(_ model: Funds?) {
        
        //        plansLabel.text = "В планах\n"
        
    }
    @objc func didTapSideMenuButton() {
        delegate?.didTapSideMenuButton()
    }
    // MARK: - Actions
    
    
}

