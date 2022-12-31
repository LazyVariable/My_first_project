//
//  CalculatorCollectionCell.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 27.12.2022.
//

import UIKit
import SnapKit

protocol ButtonCellCommand: AnyObject {
    var name: String { get }
    func execute()
}
class CalculatorCollectionCell: UICollectionViewCell {
    private var delegate:ButtonCellCommand?
    
    static var reuseId = "CalculatorCollectionCell"

    
    private lazy var button: UIButton = {
        var button = UIButton()
        button.addTarget(self, action: #selector(execute), for: UIControl.Event.touchUpInside)
        button.backgroundColor = .black
        button.layer.cornerRadius = ((UIScreen.width - (Layout.paddingCount * Layout.padding)) / Layout.itemsCoutn) / 2
        button.titleLabel?.font = UIFont.systemFont(ofSize: 50, weight: .bold)
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
    // MARK: - Public
    func configure(model: ButtonCellCommand) {
        button.setTitle(model.name, for: .normal)
        delegate = model
    }
    
    // MARK: - Private
    
    private func setupViews() {
        contentView.addSubview(button)

    }
    
    private func setupConstraints() {
        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

    }
    
    @objc func execute() {
        delegate?.execute()
    }
}

extension CalculatorCollectionCell {
    struct Layout {
        static let itemsCoutn: CGFloat = 3
        static let padding: CGFloat = 20
        static let paddingCount: CGFloat = itemsCoutn + 1
    }
}




