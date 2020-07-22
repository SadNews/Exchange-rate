//
//  NetworkManager.swift
//  RevTest
//
//  Created by Андрей Ушаков on 20.05.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import Alamofire

protocol RatesLoaderDelegate: class {
    func ratesDidLoad(_ rates: [Rate])
}

class NetworkManager {

    private let baseURL = "https://hiring.revolut.codes/api/android/latest?base="
    weak var delegate: RatesLoaderDelegate?
    
    func fetchData(_ base: String, value: Double) {
        if !CheckInternet.Connection(){
            if let data = UserDefaults.standard.value(forKey:"rate") as? Data {
                guard let songs2 = try? PropertyListDecoder().decode(Array<Rate>.self, from: data) else { return }
                self.delegate?.ratesDidLoad(songs2)
            }
        }
        let baseCode = base
        let baseValue = value
        let base = self.baseURL + base
        AF.request(base).responseJSON { [weak self] (response) in
            if let value = response.value as? [String: Any], var rates = ResultsParser.parseResults(value) {
                rates.insert(Rate(code: baseCode, value: baseValue), at: 0)
                self?.delegate?.ratesDidLoad(rates)
                UserDefaults.standard.set(try? PropertyListEncoder().encode(rates), forKey:"rate")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self?.fetchData(baseCode, value: baseValue)
            }
        }
    }
}

