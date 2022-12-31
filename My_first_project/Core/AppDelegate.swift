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
        
        let dataProvider = JsonDataProviderImpl()


        let containerVC = ContainerVC(dataProvider)
        let test = InfoVC()
        
        let navigationVC = UINavigationController(rootViewController: containerVC)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

