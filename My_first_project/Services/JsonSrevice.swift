//
//  JsonSrevice.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 17.12.2022.
//

import Foundation


protocol JsonFundsService {
    func loadJson(filename fileName: String) -> [Funds]?
}

protocol JsonExpensesService {
    func loadJson(filename fileName: String) -> [Expenses]?
}

class JsonFundsServiceImpl: JsonFundsService {
    
    func loadJson(filename fileName: String) -> [Funds]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonResponse = try decoder.decode(ItemsResponse.self, from: data)
                return jsonResponse.funds
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}

class JsonExpensesServiceImpl: JsonExpensesService {
    
    func loadJson(filename fileName: String) -> [Expenses]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonResponse = try decoder.decode(ItemsResponse.self, from: data)
                return jsonResponse.expenses
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
