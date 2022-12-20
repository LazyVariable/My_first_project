//
//  FundCell.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 18.12.2022.
//

import UIKit

protocol OpenFundsButtonCellOutput: AnyObject {
    func openFundsButtonCellDidSelect()
}

class FundsCollectionCell: UICollectionViewCell {
    
    static var reuseId = "FundsCell"
    
    weak var delegate: OpenFundsButtonCellOutput?
    
    private lazy var fundTitleLabel: UILabel = {
        var label = LabelFactory()
  
        return label.fundsAndExpensesNaneLabel
    }()
        
    private lazy var fundImage: UIImageView = {
        var image = UIImageView()
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    private lazy var fundButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .green
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(openFundsAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var fundBalanceLabel: UILabel = {
        var label = LabelFactory()

        return label.fundsAndExpensesNaneLabel
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
        contentView.addSubview(fundTitleLabel)
        contentView.addSubview(fundButton)
        contentView.addSubview(fundImage)
        contentView.addSubview(fundBalanceLabel)
        
    }
    
    private func setupConstraints() {
        
        fundTitleLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView).inset(3)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        fundButton.snp.makeConstraints { make in
            make.top.equalTo(fundTitleLabel.snp.bottom).offset(3)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.width.equalTo(50)
        }
        fundImage.snp.makeConstraints { make in
            make.edges.equalTo(fundButton).inset(7)
        }

        fundBalanceLabel.snp.makeConstraints { make in
            make.top.equalTo(fundButton.snp.bottom).offset(3)
            make.centerX.equalTo(contentView.snp.centerX)
            make.left.right.equalTo(contentView)
        }
        
    }
    // MARK: - Public
    func configure(_ model: Funds?) {
        fundTitleLabel.text = model?.name ?? ""
        fundBalanceLabel.text = model?.balance ?? ""
        fundImage.image = UIImage(systemName: model?.image ?? "")
    }
    
    //MARK: - Actions
    @objc
    func openFundsAction() {
        delegate?.openFundsButtonCellDidSelect()
    }
}
