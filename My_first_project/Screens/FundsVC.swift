//
//  FundsVC.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 20.12.2022.
//

import UIKit
import SnapKit

class FundsVC: UIViewController {
    
    var lable: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .justified
        label.text = "  В этом окне должна распологаться иформация по доходам выбранного счета"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    //MARK: - Private
    
    private func setupViews() {
        view.addSubview(lable)
        view.backgroundColor = CustomColors.cyan
    }
    
    private func setupConstraints() {
        lable.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
