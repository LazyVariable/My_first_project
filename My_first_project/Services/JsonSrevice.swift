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
protocol DataProvider{
    func loadFunds() -> [Funds]?
    func loadExpenses() -> [Expenses]?
    func loadPlans() -> [Expenses]?
    func saveFunds(item: Funds)
}
class JsonDataProviderImpl: DataProvider{
    func saveFunds(item: Funds) {
        
        var items = loadFunds()
        if items != nil {
            let index = items!.firstIndex( where: {$0.id == item.id})
            items![index!] = item
            JsonFundsServiceImpl().saveFunds(filename: "funds", items: items!)
        }
        else {
            JsonFundsServiceImpl().saveFunds(filename: "funds", items: [item])
        }
    }
    
    
    func loadFunds() -> [Funds]? {
        return JsonFundsServiceImpl().loadJson(filename: "funds")
    }
    
    func loadExpenses() -> [Expenses]? {
        return JsonExpensesServiceImpl().loadJson(filename: "expenses")
    }
    
    func loadPlans() -> [Expenses]? {
        return JsonExpensesServiceImpl().loadJson(filename: "expenses")
    }
}

class JsonFundsServiceImpl: JsonFundsService {
    
    func loadJson(filename fileName: String) -> [Funds]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonResponse = try decoder.decode([Funds].self, from: data)
                return jsonResponse
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    func saveFunds(filename fileName: String, items: [Funds]){
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let encoder = JSONEncoder()
                try encoder.encode(items).write(to: url)
                
            }
            catch {
                print("Failed to write JSON data: \(error.localizedDescription)")
            }
        }
    }
}

class JsonExpensesServiceImpl: JsonExpensesService {
    
    func loadJson(filename fileName: String) -> [Expenses]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonResponse = try decoder.decode([Expenses].self, from: data)
                return jsonResponse
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
