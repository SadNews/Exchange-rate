//
//  DemicalToString.swift
//  RevTest
//
//  Created by Андрей Ушаков on 18.06.2020.
//  Copyright © 2020 Андрей Ушаков. All rights reserved.
//

import Foundation

final class DecimalFormatter {
    
    static func toDecimalFormatter(currentValue: Double, rate: Rate, currentRate: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.roundingMode = .floor
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = 2
        let value = convert(currentValue: currentValue, rate: rate, currentRate: currentRate)
        return formatter.string(from: NSNumber(value: value)) ?? "0"
    }
    
    static func convert(currentValue: Double, rate: Rate, currentRate: Double) -> Double {
        return currentValue * rate.value / currentRate
    }
}
