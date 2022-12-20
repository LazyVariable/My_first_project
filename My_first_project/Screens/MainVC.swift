//
//  MainVC.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 16.12.2022.
//

import UIKit
import SnapKit

enum SectionType: Int, CaseIterable {
    case fundsSection    //секция со счетами
    case expensesSection //секция с расходами
}

class MainVC: UIViewController {
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    
    let sideMenuVC = SideMenuVC()
    var jsonFundsService: JsonFundsService
    var jsonExpensesService: JsonExpensesService
    
    var funds: [Funds] = []
    var expenses: [Expenses] = []
    
    
    
    private lazy var separatingLineLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = .gray
        
        return label
    }()
    
    private lazy var mainView: UIView = {
        var view = UIView()
        
        return view
    }()
    
    private lazy var headBarView: UIView = {
        var view = HeadBarView()
        view.delegate = self
        
        return view
    }()
    
    private lazy var expensesCollectionView: UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let paddingSize = Layout.paddingCount * Layout.padding
        let cellSize = (UIScreen.width - paddingSize) / Layout.itemsCount
        layout.itemSize = CGSize(width: cellSize, height: cellSize + 10)
        layout.minimumLineSpacing = Layout.padding
        layout.minimumInteritemSpacing = Layout.padding
        layout.sectionInset = UIEdgeInsets(top: Layout.padding, left: Layout.padding, bottom: Layout.padding, right: Layout.padding)
        
        var collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FundsCollectionCell.self, forCellWithReuseIdentifier: FundsCollectionCell.reuseId)
        collectionView.register(ExpensesCollectionCell.self, forCellWithReuseIdentifier: ExpensesCollectionCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.scrollsToTop = true
        
        return collectionView
    }()
    
    // MARK: Lifecycle
    init(jsonService1: JsonFundsService, jsonService2: JsonExpensesService) {
        self.jsonFundsService = jsonService1
        self.jsonExpensesService = jsonService2
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
    
    func fetchLocalItems() {
        funds = jsonFundsService.loadJson(filename: "items") ?? []
        expenses = jsonExpensesService.loadJson(filename: "items") ?? []
        
        mainView.reloadInputViews()
    }
    
    // MARK: - Private
    
    private func setupViews() {
        
        addChild(sideMenuVC)
        view.addSubview(sideMenuVC.view)
        sideMenuVC.didMove(toParent: self)
        view.addSubview(mainView)
        mainView.addSubview(headBarView)
        mainView.addSubview(separatingLineLabel)
        mainView.addSubview(expensesCollectionView)
        mainView.backgroundColor = .white
        view.backgroundColor = .white
    }
    
    private func setupConstraints(){
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headBarView.snp.makeConstraints { make in
            make.top.left.right.equalTo(mainView.safeAreaLayoutGuide)
            
        }
        separatingLineLabel.snp.makeConstraints { make in
            make.top.equalTo(headBarView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        expensesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(separatingLineLabel.snp.bottom)
            make.left.right.height.equalTo(mainView)
        }
    }
    func showFundsScreen() {
        let fundsVC = ScreenFactoryImpl().makeFundsViewController()
        self.navigationController?.pushViewController(fundsVC, animated: true)
    }
}
//MARK: - Extensions
//MARK: - CollectonViewExtension
extension MainVC: UICollectionViewDelegate {
    
}
extension MainVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sectionType = SectionType.init(rawValue: section) {
            
            switch sectionType {
            case .fundsSection:
                return funds.count
            case .expensesSection:
                return expenses.count
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let sectionType = SectionType.init(rawValue: indexPath.section) {
            
            switch sectionType {
            case .fundsSection:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FundsCollectionCell.reuseId, for: indexPath) as? FundsCollectionCell else { return UICollectionViewCell() }
                let fund = funds[indexPath.row]
                cell.configure(fund)
                
                return cell
                
            case .expensesSection:
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExpensesCollectionCell.reuseId, for: indexPath) as? ExpensesCollectionCell else { return UICollectionViewCell() }
                let expense = expenses[indexPath.row]
                cell.configure(expense)
                
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

extension UIScreen {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}
extension MainVC {
    struct Layout {
        static let itemsCount: CGFloat = 4 // количество ячеек в строке
        static let padding: CGFloat = 5 // размер пропуска между ячейками
        static let paddingCount: CGFloat = itemsCount + 1 //количество пропусков между элементами и вью
    }
}

//MARK: - ButtonsExtension
extension MainVC: OpenFundsButtonCellOutput {
    
    func openFundsButtonCellDidSelect() {
        showFundsScreen()
    }
}

extension MainVC: OpenSideBarViewDelegate {
    func didTapSideMenuButton() {
        toogleMenu(complition: nil)
    }
    
    func toogleMenu(complition: (() -> Void)?) {
        switch menuState {
        case .closed:
            //open
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                
                self.mainView.frame.origin.x = self.view.frame.size.width - 100
                
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
            
        case .opened:
            //close
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                
                self.mainView.frame.origin.x = 0
                
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        complition?()
                    }
                }
            }
        }
    }
}
extension MainVC: SideMenuVCDelegate {
    func didSelect(menuItem: MenuOptions) {
        toogleMenu { [weak self] in
            switch menuItem {
                
            case .main:
                
                break
            case .info:
                let vc = InfoVC()
                self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            case .shareApp:
                break
            case .settings:
                break
            }
        }
    }
}
