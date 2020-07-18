//
//  TableViewCell.swift
//  RevTest
//
//  Created by Андрей Ушаков on 28.05.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import UIKit

protocol RateCellDelegate: class {
    func selctRate(rate: Rate)
    func amountChanged(amount: Double, rate: Rate)
}

class TableViewCell: UITableViewCell, UITextFieldDelegate {
    var rate: Rate?
    let network = NetworkManager()
    weak var delegate: RateCellDelegate?
    @IBOutlet weak var info: UILabel!
    @IBOutlet weak var info2: UITextField!
    
    override func awakeFromNib() {
        info2.keyboardType = .decimalPad
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let aSet = NSCharacterSet(charactersIn:"0123456789.").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        
        let updatedString = textField.text ?? ""
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let amount = formatter.number(from: updatedString)
        if let rate = rate {
            delegate?.amountChanged(amount: amount as? Double ?? 1, rate: rate)
        }
        
        return string == numberFiltered
    }
    
    
    func setup(rate: Rate, currentValue: Double, currentRate: Double) {
        self.rate = rate
        info.text = rate.code
        info2.text = DecimalFormatter.toDecimalFormatter(currentValue: currentValue,
                                                         rate: rate,
                                                         currentRate: currentRate)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.selctRate(rate: rate ?? Rate.init(code: "", value: 0))
    }
    
    
}
