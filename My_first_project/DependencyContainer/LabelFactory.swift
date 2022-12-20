//
//  FactoryLabel.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 17.12.2022.
//

import UIKit
import SnapKit

class LabelFactory: UIViewController {
    
    lazy var categoryNameLabel: UILabel = UILabel.makeCategoryNameTitle() // Имена категорий информации/счетов/расходов
    lazy var fundsAndExpensesNaneLabel: UILabel = UILabel.makeDetailsTitle() // Состояние информации/счетов/расходов
    lazy var expensePlanLabel: UILabel = UILabel.makePlanTitle() // Запланированные расходы
}

extension UILabel {
    static func makeCategoryNameTitle() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        return label
    }
}

extension UILabel {
    static func makeDetailsTitle() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }
}

extension UILabel {
    static func makePlanTitle() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        return label
    }
}

