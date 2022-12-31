//
//  MainVC.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 16.12.2022.
//

import UIKit
import SnapKit



class ContainerVC: UIViewController {
    enum MenuState {
        case opened
        case closed
    }
    
    private var dataProvider: DataProvider
    
    private var menuState: MenuState = .closed
    
    let sideMenuVC = SideMenuVC()
    var mainMenuVC: MainMenuVC
    
    private lazy var mainMenuView: UIView = {
        var view = UIView()
        return view
    }()
    
    init(_ dataProvider: DataProvider) {
        mainMenuVC = MainMenuVC(dataProvider)
        self.dataProvider = dataProvider
        super.init(nibName: nil, bundle: nil)
        mainMenuVC.tableViewHeader.delegateOpenSide = self
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    // MARK: - Public
    //        func configure(_ funds: [Funds]) {
    //            self.funds = funds
    //        }
    // MARK: - Private
    
    private func setupViews() {
        view.backgroundColor = .white
        addChild(sideMenuVC)
        view.addSubview(sideMenuVC.view)
        sideMenuVC.didMove(toParent: self)
        view.addSubview(mainMenuView)
        mainMenuVC.tableViewHeader.delegateOpenFundsChoose = self
        mainMenuView.addSubview(mainMenuVC.view)
        mainMenuView.backgroundColor = .white
        navigationController?.isNavigationBarHidden =  true
    }
    
    private func setupConstraints(){
        mainMenuView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        mainMenuVC.view.snp.makeConstraints { make in
            make.top.equalTo(mainMenuView.safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    // MARK: - Navigation
    
    func openChooseFundsView() {
        let chooseFundsViewController = ScreenFactoryImpl().makeChooseFundsViewController()
        self.navigationController?.pushViewController(chooseFundsViewController, animated: true)
        navigationController?.isNavigationBarHidden =  false
        chooseFundsViewController.observer = self
    }
    
    func openInputDataView(model: Funds) {
        let incomeDataViewController = ScreenFactoryImpl().makeIncomeDataViewController()
        incomeDataViewController.delegate = self
        incomeDataViewController.configure(model)
        self.navigationController?.pushViewController(incomeDataViewController, animated: true)
        navigationController?.isNavigationBarHidden =  false
    }
    
    func openInfoView() {
        let infoViewController = ScreenFactoryImpl().makeInfoViewController()
        self.present(UINavigationController(rootViewController: infoViewController), animated: true, completion: nil)
        navigationController?.isNavigationBarHidden =  true
        infoViewController.delegate = self
//        infoViewController.dele
    }
    
    //    func showFundsScreen() {
    //        let fundsVC = ScreenFactoryImpl().makeFundsViewController()
    //        self.navigationController?.pushViewController(fundsVC, animated: true)
    //    }
}
//MARK: - Extensions
//extension ContainerVC: OpenFundsButtonCellOutput {
//
//    func openFundsButtonCellDidSelect() {
//        showFundsScreen()
//    }
//}
extension ContainerVC: InfoVCDelegate{
    
}
extension ContainerVC: InputDataViewDelegate{
    func accept(item: Funds?, value: Float){
        navigationController?.popToViewController(self, animated: true)
        navigationController?.isNavigationBarHidden =  true
        
        if item != nil {
            let tempVarBalance = (Float(item!.balance) ?? 0) + value
            let newItem = Funds(id: item?.id ?? "" , name: item?.name ?? "", image: item?.image ?? "", balance: String(tempVarBalance))
            dataProvider.saveFunds(item: newItem)
            mainMenuVC.fetchLocalItems()
        }
        
    }
}
extension ContainerVC: OpenSideBarViewDelegate {
    func didTapSideMenuButton() {
        toogleMenu(complition: nil)
    }
    
    func toogleMenu(complition: (() -> Void)?) {
        switch menuState {
        case .closed:
            //open
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                
                self.mainMenuView.frame.origin.x = self.view.frame.size.width - 100
                
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
            
        case .opened:
            //close
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                
                self.mainMenuView.frame.origin.x = 0
                
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
extension ContainerVC: SideMenuVCDelegate {
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

extension ContainerVC : OpenChooseFundsViewDelegate{
    func didTapChooseFundsButton() {
        openChooseFundsView()
    }
}
extension ContainerVC: TapObserver{
    func onCancel() {
        navigationController?.isNavigationBarHidden = true
    }
    
    func onAccept() {
        let uialert = UIAlertController(title: "Внимание", message: "Выберите счет", preferredStyle: UIAlertController.Style.alert)
        uialert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
        self.present(uialert, animated: true, completion:  nil)
    }
}
extension ContainerVC : OpenAddFundsViewDelegate{
    func openAddFundsViewDelegate(model: Funds?) {
        if model == nil
        {
            return
        }
        openInputDataView(model: model!)
    }
}
