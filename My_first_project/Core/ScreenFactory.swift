//
//  ScreenFactory.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 20.12.2022.
//

import UIKit
protocol ScreenFactory {
    func makeFundsViewController() -> FundsVC
//    func makeInfoViewController() -> InfoVC
//    func makeSettingsViewController() -> SettingsVC
}
class ScreenFactoryImpl: ScreenFactory {

    func makeFundsViewController() -> FundsVC {
        let fundsVC = FundsVC()
        
        return fundsVC
    }
    
//    func makeInfoViewController() -> InfoVC {
//        let infoVC = InfoVC()
//
//        return infoVC
//    }
    
//    func makeSettingsViewController() -> SettingsVC {
//        let settingsVC = SettingsVC()
//
//        return settingsVC
//    }
}
