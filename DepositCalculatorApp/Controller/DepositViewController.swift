//
//  DepositViewController.swift
//  DepositCalculatorApp
//
//  Created by Daulet Omar on 10.12.2024.
//

import UIKit
import SnapKit

class DepositViewController: UIViewController, UITableViewDataSource {
    
    var amountTextField: UITextField!
    var currencyLabel: UILabel!
    var durationButton3Months: UIButton!
    var durationButton6Months: UIButton!
    var durationButton12Months: UIButton!
    var calculateButton: UIButton!
    
    var resultsTableView: UITableView!
    
    var viewModel = DepositViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
    }
    
    private func setupUI() {
        // Amount TextField
        amountTextField = UITextField()
        amountTextField.placeholder = "Enter Amount"
        amountTextField.borderStyle = .roundedRect
        amountTextField.keyboardType = .decimalPad
        self.view.addSubview(amountTextField)
        
        // Currency Label
        currencyLabel = UILabel()
        currencyLabel.text = "$"
        currencyLabel.font = UIFont.systemFont(ofSize: 18)
        currencyLabel.textColor = .black
        self.view.addSubview(currencyLabel)
        
        // Duration Buttons
        durationButton3Months = UIButton()
        durationButton3Months.setTitle("3 months", for: .normal)
        durationButton3Months.setTitleColor(.blue, for: .normal)
        durationButton3Months.addTarget(self, action: #selector(durationButtonTapped), for: .touchUpInside)
        self.view.addSubview(durationButton3Months)
        
        durationButton6Months = UIButton()
        durationButton6Months.setTitle("6 months", for: .normal)
        durationButton6Months.setTitleColor(.blue, for: .normal)
        durationButton6Months.addTarget(self, action: #selector(durationButtonTapped), for: .touchUpInside)
        self.view.addSubview(durationButton6Months)
        
        durationButton12Months = UIButton()
        durationButton12Months.setTitle("12 months", for: .normal)
        durationButton12Months.setTitleColor(.blue, for: .normal)
        durationButton12Months.addTarget(self, action: #selector(durationButtonTapped), for: .touchUpInside)
        self.view.addSubview(durationButton12Months)
        
        calculateButton = UIButton()
        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.setTitleColor(.white, for: .normal)
        calculateButton.backgroundColor = .green
        calculateButton.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
        self.view.addSubview(calculateButton)
        
        resultsTableView = UITableView()
        resultsTableView.register(DepositCell.self, forCellReuseIdentifier: "DepositCell")
        resultsTableView.dataSource = self
        self.view.addSubview(resultsTableView)
        
        amountTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        
        currencyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(amountTextField)
            make.right.equalTo(amountTextField.snp.left).offset(-10)
        }
        
        durationButton3Months.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        durationButton6Months.snp.makeConstraints { make in
            make.top.equalTo(durationButton3Months.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        durationButton12Months.snp.makeConstraints { make in
            make.top.equalTo(durationButton6Months.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        calculateButton.snp.makeConstraints { make in
            make.top.equalTo(durationButton12Months.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        
        resultsTableView.snp.makeConstraints { make in
            make.top.equalTo(calculateButton.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc func durationButtonTapped(sender: UIButton) {
        resetButtonColors()
        sender.backgroundColor = .lightGray
        
        switch sender {
        case durationButton3Months:
            viewModel.selectedDuration = 3
        case durationButton6Months:
            viewModel.selectedDuration = 6
        case durationButton12Months:
            viewModel.selectedDuration = 12
        default:
            break
        }
    }
    
    private func resetButtonColors() {
        durationButton3Months.backgroundColor = nil
        durationButton6Months.backgroundColor = nil
        durationButton12Months.backgroundColor = nil
    }
    
    @objc func calculateButtonTapped() {
        guard let amountText = amountTextField.text, let amount = Double(amountText), amount > 0 else {
            return
        }
        
        let interestRate = 5.0
        let result = viewModel.calculateDeposit(amount: amount, interestRate: interestRate)
        let percentageIncrease = viewModel.calculatePercentageIncrease(amount: amount)
        let duration = viewModel.selectedDuration
        
        let formattedResult = formatCurrency(result)
        let formattedPercentage = String(format: "%.2f", percentageIncrease)
        
        let resultData = Deposit(amount: formattedResult, interestRate: "\(interestRate)%", percentageIncrease: "\(formattedPercentage)%", duration: "\(duration)")
        viewModel.addResultData(resultData)
        
        resultsTableView.reloadData()
    }
    
    private func formatCurrency(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        return formatter.string(from: NSNumber(value: amount)) ?? "$0.00"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DepositCell", for: indexPath) as! DepositCell
        let depositData = viewModel.results[indexPath.row]
        cell.configure(with: depositData)
        return cell
    }
}
