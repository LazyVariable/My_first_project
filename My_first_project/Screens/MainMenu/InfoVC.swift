//
//  InfoVC.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 19.12.2022.
//

import UIKit
import SnapKit
//protocol InputDataViewDelegate: AnyObject {
//    func accept(item: Funds?, value: Float)
//}

protocol InfoVCDelegate: AnyObject {
    
}
class InfoVC: UIViewController {
    weak var delegate: InfoVCDelegate?
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .justified
        label.text = "  Это приложение разработано Микрюковым А.А., как дипломный проект, на курсе дистанционного обучения \"iOS разработчик\" в ведущей IT школе в Беларуси <TeachMeSkills/>."
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }

    // MARK: - Private
    private func setupViews() {
        view.addSubview(label)
        view.backgroundColor = .white
        title = "Об этом приложении"
    }
    
    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalTo(view).inset(10)
            make.width.equalTo(view).inset(10)
        }
    }
}
