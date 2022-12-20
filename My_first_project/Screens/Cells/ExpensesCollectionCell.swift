//
//  ExpensesCollectionCell.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 18.12.2022.
//

import UIKit

class ExpensesCollectionCell: UICollectionViewCell {
    
    static let reuseId = "ExpensesCell"
    
    private lazy var expenseTitleLabel: UILabel = {
        var label = LabelFactory()

        return label.fundsAndExpensesNaneLabel
    }()
    
    private lazy var expenseImage: UIImageView = {
        var image = UIImageView()
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var expenseButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = 25
        return button
    }()
    
    private lazy var expenseBalanceLabel: UILabel = {
        var label = LabelFactory()
        
        return label.fundsAndExpensesNaneLabel
    }()
    
    private lazy var expensesPlanLabel: UILabel = {
        var label = LabelFactory()
        
        return label.expensePlanLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Private
    private func setupViews() {
        
        contentView.addSubview(expenseTitleLabel)
        contentView.addSubview(expenseButton)
        contentView.addSubview(expenseImage)
        contentView.addSubview(expenseBalanceLabel)
        contentView.addSubview(expensesPlanLabel)
    }
    
    private func setupConstraints() {
        
        expenseTitleLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView).inset(3)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        expenseButton.snp.makeConstraints { make in
            make.top.equalTo(expenseTitleLabel.snp.bottom).offset(3)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.width.equalTo(50)
        }
        expenseImage.snp.makeConstraints { make in
            make.edges.equalTo(expenseButton).inset(7)
        }
        expenseBalanceLabel.snp.makeConstraints { make in
            make.top.equalTo(expenseButton.snp.bottom).offset(3)
            make.centerX.equalTo(contentView.snp.centerX)
            make.left.right.equalTo(contentView)
        }
        expensesPlanLabel.snp.makeConstraints { make in
            make.top.equalTo(expenseBalanceLabel.snp.bottom)
            make.centerX.equalTo(contentView.snp.centerX)
            make.left.right.equalTo(contentView)
        }
        
        
    }
    //     MARK: - Public
    func configure(_ model: Expenses?) {
        expenseTitleLabel.text = model?.name ?? ""
        expenseBalanceLabel.text = model?.amount ?? ""
        expensesPlanLabel.text = model?.plan ?? ""
        expenseImage.image = UIImage(systemName: model?.image ?? "")
        
    }
}
