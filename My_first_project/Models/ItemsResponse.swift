//
//  ItemsResponse.swift
//  My_first_project
//
//  Created by Алексей Микрюков on 17.12.2022.
//

import Foundation

// MARK: - ItemsResponse
struct ItemsResponse: Codable {
    let funds: [Funds]
    let expenses: [Expenses]
}

// MARK: - Expense
struct Expenses: Codable {
    let id, name, image, amount: String
    let plan: String
}

// MARK: - Fund
struct Funds: Codable {
    let id, name, image, balance: String
}
