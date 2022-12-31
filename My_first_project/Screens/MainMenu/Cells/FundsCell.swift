//
//  FundsCell.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 27.11.2022.
//

import UIKit


class FundsCell: UITableViewCell {
    
    static var reuseId = "FundsCell"
    
    var funds: [Funds] = []
    
    lazy var fundsCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let paddingSize = Layout.paddingCount * Layout.padding
        let cellSize = (UIScreen.width - paddingSize) / Layout.itemsCoutn
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        layout.minimumLineSpacing = Layout.padding
        layout.minimumInteritemSpacing = Layout.padding
        layout.sectionInset = UIEdgeInsets(top: Layout.padding, left: Layout.padding, bottom: Layout.padding, right: Layout.padding)
        
        var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FundsCollectionCell.self, forCellWithReuseIdentifier: FundsCollectionCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollsToTop = true
        
        
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
    func configure(_ funds: [Funds]) {
        self.funds = funds
    }
    
    // MARK: - Private
    private func setupViews() {
        contentView.addSubview(fundsCollectionView)
    }
    
    private func setupConstraints() {
        fundsCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(120)
        }
    }
}

extension FundsCell: UICollectionViewDelegate {
    
}

extension FundsCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return funds.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FundsCollectionCell.reuseId, for: indexPath) as? FundsCollectionCell else { return UICollectionViewCell() }
        
        let fund = funds[indexPath.row]
        cell.configure(model: fund)
        
        return cell
    }
    
    
}
extension FundsCell {
    struct Layout {
        static let itemsCoutn: CGFloat = 4
        static let padding: CGFloat = 5
        static let paddingCount: CGFloat = itemsCoutn + 1
    }
}
