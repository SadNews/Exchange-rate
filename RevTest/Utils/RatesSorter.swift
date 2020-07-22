//
//  ResultSorter.swift
//  RevTest
//
//  Created by Андрей Ушаков on 17.07.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//
class RatesSorter {
    
    static func sortRates(newRates: [Rate], oldRates: [Rate]) -> [Rate] {
        var copy = newRates
        var result: [Rate] = []
        for rate in oldRates {
            if let rate = copy.firstIndex(where: { $0.code == rate.code }) {
                result.append(copy[rate])
                copy.remove(at: rate)
            } else {
                result.append(rate)
            }
        }
        result.append(contentsOf: copy)
        return result
    }
}
