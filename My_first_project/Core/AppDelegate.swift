//
//  AppDelegate.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 16.12.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let jsonService1 = JsonFundsServiceImpl()
        let jsonService2 = JsonExpensesServiceImpl()
        let mainVC = MainVC(jsonService1: jsonService1, jsonService2: jsonService2) //Dependency injection -> через инициализатор
        
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

