//
//  NetworkManager.swift
//  RevTest
//
//  Created by Андрей Ушаков on 28.05.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import Alamofire

protocol RatesLoaderDelegate: class {
    func didReceiveRates(_ rates: [Rate])
}

class NetworkManager {
    
    weak var delegate: RatesLoaderDelegate?
    private let baseURL = "https://hiring.revolut.codes/api/android/latest?base="
    
    func fetchData(_ base: String, value: Double) {
        let baseCode = base
        let baseValue = value
        let base = self.baseURL + base
        AF.request(base).responseJSON { [weak self] (response) in
            if let value = response.value as? [String: Any], var rates = ResultsParser.parseResults(value) {
                rates.insert(Rate(code: baseCode, value: baseValue), at: 0)
                self?.delegate?.didReceiveRates(rates)
                    }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self?.fetchData(baseCode, value: baseValue)
            }
        }
    }
}

