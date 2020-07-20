//
//  TableViewCell.swift
//  RevTest
//
//  Created by Андрей Ушаков on 28.05.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import UIKit

protocol RateCellDelegate: class {
    func selectRate(rate: Rate)
    func amountChanged(amount: Double, rate: Rate)
}

class TableViewCell: UITableViewCell, UITextFieldDelegate {
    var rate: Rate?
    let network = NetworkManager()
    weak var delegate: RateCellDelegate?
    @IBOutlet weak var currencies: UILabel!
    @IBOutlet weak var currencieRate: UITextField!
    @IBOutlet weak var flagIcon: UIImageView!
    
    override func awakeFromNib() {
        currencieRate.keyboardType = .decimalPad
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let updatedString = textField.text ?? ""
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let amount = formatter.number(from: updatedString)
        if let rate = rate {
            delegate?.amountChanged(amount: amount as? Double ?? 1, rate: rate)
        }
    }
    
    func setup(rate: Rate, currentValue: Double, currentRate: Double) {
        self.rate = rate
        currencies.text = rate.code
        currencieRate.text = DecimalFormatter.toDecimalFormatter(currentValue: currentValue,
                                                                 rate: rate,
                                                                 currentRate: currentRate)
        flagIcon.image = UIImage(named: rate.code.lowercased())
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.selectRate(rate: rate ?? Rate.init(code: "", value: 0))
    }
    
    
}
