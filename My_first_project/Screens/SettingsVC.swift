//
//  SettingsVC.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 19.12.2022.
//

import UIKit
import SnapKit

class SettingsVC: UIViewController {
    
    lazy private var label: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .justified
        label.text = "  Тут видимо будут находится какие-то настройки приложения, которые еще нужно придумать. Можно добавить:\n  -выбор валюты;\n  -выбор языка;\n  -уведомления;\n  -пароль;\n  -и т.д."
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupConstraints()
    }
    
    //MARK: - Private
    
    private func setupView() {
        view.addSubview(label)
        view.backgroundColor = .systemRed
        title = "Настройки"
    }
    
    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view).inset(10)
            make.width.equalTo(view).inset(10)
        }
    }
}
