//
//  TableViewCell.swift
//  RevTest
//
//  Created by Андрей Ушаков on 28.05.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import UIKit

protocol RateCellDelegate: class {
    func didSelectRate(rate: Rate)
    func amountChanged(amount: Double, rate: Rate)
}

final class TableViewCell: UITableViewCell, UITextFieldDelegate {
    private var rate: Rate?
    private let network = NetworkManager()
    weak var delegate: RateCellDelegate?
    @IBOutlet private weak var currencies: UILabel!
    @IBOutlet private weak var currencieRate: UITextField!
    @IBOutlet private weak var flagIcon: UIImageView!
    
    override func awakeFromNib() {
        currencieRate.keyboardType = .decimalPad
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.delegate?.didSelectRate(rate: rate!)
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
        delegate?.didSelectRate(rate: rate ?? Rate.init(code: "", value: 0))
    }
    
    
}
