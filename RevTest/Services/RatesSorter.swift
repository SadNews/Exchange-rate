//
//  ResultSorter.swift
//  RevTest
//
//  Created by Андрей Ушаков on 17.07.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//
class RatesSorter {
    
    static func sortRates(newRates: [Rate], oldRates: [Rate]) -> [Rate] {
        var newCopy = newRates
        var result: [Rate] = []
        for rate in oldRates {
            if let index = newCopy.firstIndex(where: { $0.code == rate.code }) {
                result.append(newCopy[index])
                newCopy.remove(at: index)
            } else {
                result.append(rate)
            }
        }
        result.append(contentsOf: newCopy)
        
        return result
    }
    
}
