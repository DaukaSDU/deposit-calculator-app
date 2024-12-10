//
//  DepositCell.swift
//  DepositCalculatorApp
//
//  Created by Daulet Omar on 10.12.2024.
//

import UIKit

class DepositCell: UITableViewCell {
    
    var resultLabel: UILabel!
    var interestRateLabel: UILabel!
    var percentageIncreaseLabel: UILabel!
    var durationLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        resultLabel = UILabel()
        resultLabel.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(resultLabel)
        
        interestRateLabel = UILabel()
        interestRateLabel.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(interestRateLabel)
        
        percentageIncreaseLabel = UILabel()
        percentageIncreaseLabel.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(percentageIncreaseLabel)
        
        durationLabel = UILabel()
        durationLabel.font = UIFont.systemFont(ofSize: 16)
        self.contentView.addSubview(durationLabel)
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(15)
        }
        
        interestRateLabel.snp.makeConstraints { make in
            make.top.equalTo(resultLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(15)
        }
        
        percentageIncreaseLabel.snp.makeConstraints { make in
            make.top.equalTo(interestRateLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(15)
        }
        
        durationLabel.snp.makeConstraints { make in
            make.top.equalTo(percentageIncreaseLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with deposit: Deposit) {
        resultLabel.text = "Amount: \(deposit.amount)"
        interestRateLabel.text = "Interest Rate: \(deposit.interestRate)"
        percentageIncreaseLabel.text = "Increase: \(deposit.percentageIncrease)"
        durationLabel.text = "Duration: \(deposit.duration) months"
    }
}
