//
//  ViewController.swift
//  RevTest
//
//  Created by Андрей Ушаков on 28.05.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import UIKit

private class ViewController: UITableViewController, UITextFieldDelegate, RatesLoaderDelegate, RateCellDelegate {
    
    var network = NetworkManager()
    private var rates: [Rate] = []
    private var currentValue: Double = 1
    private var currentRate = Rate(code: "EUR", value: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        network.delegate = self
        
        network.fetchData("EUR", value: currentValue)
        
    }
    
    func amountChanged(amount: Double, rate: Rate) {
        currentRate = rate
        currentValue = amount
        updateVisibleRows()
    }
    
    func internetConnectionErrorAlert(Message: String){
        let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func selctRate(rate: Rate) {
        if let index = rates.firstIndex(where: { rate.code == $0.code }) {
            selectRate(index: index)
        }
    }
    func ratesDidLoad(_ rates: [Rate]) {
        if self.rates.count == 0 {
            self.rates = rates
            tableView.reloadData()
        } else {
            self.rates = RatesSorter.sortRates(newRates: rates, oldRates: self.rates)
            updateVisibleRows()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rates.count
    }
    
    func selectRate(index: Int) {
        let newRate = rates[index]
        
        currentRate = newRate
        currentValue = newRate.value
        
        rates.remove(at: index)
        rates.insert(newRate, at: 0)
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        tableView.performBatchUpdates({
            tableView.moveRow(at: (IndexPath(row: index, section: 0)),
                              to: (IndexPath(row: 0, section: 0)))
        })
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectRate(index: indexPath.row)
    }
    
    private func updateVisibleRows() {
        let allButFirst = (self.tableView.indexPathsForVisibleRows ?? []).filter { $0.row != 0 }
        self.tableView.reloadRows(at: allButFirst, with: .none)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let rate = rates[indexPath.row]
        cell.setup(rate: rate, currentValue: currentValue, currentRate: currentRate.value)
        cell.delegate = self
        return cell
    }
}
