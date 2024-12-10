//
//  DepositViewModel.swift
//  DepositCalculatorApp
//
//  Created by Daulet Omar on 10.12.2024.
//

import Foundation

class DepositViewModel {
    var results: [Deposit] = []
    var selectedDuration: Int = 0
    
    func calculateDeposit(amount: Double, interestRate: Double) -> Double {
        let result = amount * pow(1 + interestRate / 100, Double(selectedDuration) / 12)
        return result
    }
    
    func calculatePercentageIncrease(amount: Double) -> Double {
        return (calculateDeposit(amount: amount, interestRate: 0.05) / amount) * 100
    }
    
    func addResultData(_ resultData: Deposit) {
        results.removeAll()
        results.append(resultData)
    }
}
