//
//  ScreenFactory.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 20.12.2022.
//

import UIKit
protocol ScreenFactory {
    func makeChooseFundsViewController() -> ChooseFundsVC
    func makeIncomeDataViewController() -> InputDataMenuVC
    func makeInfoViewController() -> InfoVC
//    func makeSettingsViewController() -> SettingsVC
}
class ScreenFactoryImpl: ScreenFactory {

    func makeChooseFundsViewController() -> ChooseFundsVC {
        let dataProvider = JsonDataProviderImpl()
        let chooseFundsVC = ChooseFundsVC(dataProvider: dataProvider)

        return chooseFundsVC
    }
    
    func makeIncomeDataViewController() -> InputDataMenuVC {
        let incomeDataVC = InputDataMenuVC()

        return incomeDataVC
    }
    
    func makeInfoViewController() -> InfoVC {
        let infoVC = InfoVC()

        return infoVC
    }
}
