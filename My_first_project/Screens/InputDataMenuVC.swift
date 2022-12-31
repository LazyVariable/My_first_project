//
//  ViewController.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 27.12.2022.
//

import UIKit
import SnapKit

protocol InputDataViewDelegate: AnyObject {
    func accept(item: Funds?, value: Float)
}
class InputDataMenuVC: UIViewController {
    
    var buttonts: Array = [""]
    
    weak var delegate: InputDataViewDelegate?
    private let dataInput = InputData()
    private var funds: Funds?

    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CalculatorCell.self, forCellReuseIdentifier: CalculatorCell.reuseId)
        tableView.separatorStyle = .singleLine
        
        tableView.isScrollEnabled = false
        
        
        return tableView
    }()
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
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
        func configure(_ item: Funds) {
            self.funds = item
            title = "Получен доход в \(item.name)"
        }
    // MARK: - Private
    
    private func setupViews() {
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .done, target: self, action: #selector(didTapAcceptButton))
//        navigationController?.navigationItem.backItem?.title = ""
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    @objc
    private func didTapAcceptButton(){
        let value = Float(dataInput.value ?? "") ?? 0.0
        delegate?.accept(item: funds, value: value)
    }

}
extension InputDataMenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(tableView.bounds.height)
    }
    
}

extension InputDataMenuVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: CalculatorCell.reuseId, for: indexPath) as? CalculatorCell else { return UITableViewCell() }
        cell.backgroundColor = .white
        cell.configure(model: dataInput)
        return cell
    }
    
    
}
