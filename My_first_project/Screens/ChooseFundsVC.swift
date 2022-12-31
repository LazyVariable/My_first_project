//
//  CollectionViewViewController.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 29.12.2022.
//

import UIKit
protocol TapObserver: OpenAddFundsViewDelegate{
    func onCancel()
    func onAccept()
}

class ChooseFundsVC: UIViewController {
    
    var funds: [Funds] = []
    var dataProvider: DataProvider
    var observer: TapObserver?
   
        
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let paddingSize = Layout.paddingCount * Layout.padding
        let cellSize = (UIScreen.width - paddingSize) / Layout.itemsCoutn
        layout.itemSize = CGSize(width: cellSize, height: cellSize)
        layout.minimumLineSpacing = Layout.padding
        layout.minimumInteritemSpacing = Layout.padding
        layout.sectionInset = UIEdgeInsets(top: Layout.padding, left: Layout.padding, bottom: Layout.padding, right: Layout.padding)
        
        var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FundsCollectionCell.self, forCellWithReuseIdentifier: FundsCollectionCell.reuseId)
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.scrollsToTop = true
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    init(dataProvider: JsonDataProviderImpl) {
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

    }
    // MARK: - Public
    //    func configure(_ funds: [Funds]) {
    //        self.funds = funds
    //    }
    // MARK: - Private
    private func setupViews() {
        title = "Добавление дохода"
       navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(didTapCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .done, target: self, action: #selector(didTapAccepButton))
        view.addSubview(collectionView)
        view.backgroundColor = .white

    }
    
    private func setupConstraints() {
//        navigationBar.snp.makeConstraints { make in
//            make.edges.equalTo(view.safeAreaLayoutGuide)
//        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    @objc func didTapAccepButton() {
        observer?.onAccept()
    }


    @objc func didTapCancelButton() {
        navigationController?.popViewController(animated: true)
        observer?.onCancel()
    }
}

extension ChooseFundsVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return funds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FundsCollectionCell.reuseId, for: indexPath) as? FundsCollectionCell else { return UICollectionViewCell() }
        let fund = funds[indexPath.row]
        cell.configure(model: fund)
        cell.delegateAddFundsChoose = observer
        
        return cell
    }
    
    
}
extension ChooseFundsVC {
    struct Layout {
        static let itemsCoutn: CGFloat = 4
        static let padding: CGFloat = 5
        static let paddingCount: CGFloat = itemsCoutn + 1
    }
}

