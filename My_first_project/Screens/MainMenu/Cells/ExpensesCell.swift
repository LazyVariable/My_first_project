//
//  FundsCell.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 27.11.2022.
//

import UIKit


class ExpensesCell: UITableViewCell {

    static var reuseId = "ExpensesCell"
    
    var expenses: [Expenses] = []
    
    lazy var expensesCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let paddingSize = Layout.paddingCount * Layout.padding
        let cellSize = (UIScreen.width - paddingSize) / Layout.itemsCoutn
        layout.itemSize = CGSize(width: cellSize, height: cellSize + 20)
        layout.minimumLineSpacing = Layout.padding
        layout.minimumInteritemSpacing = Layout.padding
        layout.sectionInset = UIEdgeInsets(top: Layout.padding, left: Layout.padding, bottom: Layout.padding, right: Layout.padding)
        
        var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ExpensesCollectionCell.self, forCellWithReuseIdentifier: ExpensesCollectionCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.scrollsToTop = true
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Public
    func configure(_ expenses: [Expenses]) {
        self.expenses = expenses
    }
    
    // MARK: - Private
    private func setupViews() {
        contentView.addSubview(expensesCollectionView)
    }
    
    private func setupConstraints() {
        expensesCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)

            make.height.equalTo(580)
        }
    }
}

extension ExpensesCell: UICollectionViewDelegate {

}

extension ExpensesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return expenses.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpensesCollectionCell.reuseId, for: indexPath) as? ExpensesCollectionCell else { return UICollectionViewCell() }
        
        let expense = expenses[indexPath.row]
        cell.configure(model: expense)
        
        return cell
    }
    
    
}
extension ExpensesCell {
    struct Layout {
        static let itemsCoutn: CGFloat = 4
        static let padding: CGFloat = 5
        static let paddingCount: CGFloat = itemsCoutn + 1
    }
}
